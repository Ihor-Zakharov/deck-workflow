#!/usr/bin/env python3
"""Live-reload preview server for a deck folder — the open browser tab always shows the latest build.
Usage: python3 scripts/serve.py <deck-dir> [port]     → http://localhost:8765/<deck>.html
Serves the folder over HTTP and injects a tiny poller into every .html page: when the file changes on disk,
the page reloads itself and returns to the same slide (#n). No dependencies; works on Linux, macOS, Windows and WSL2
(the Windows browser reaches WSL's localhost). Stop with Ctrl+C.
"""
import http.server, os, sys, json, time, urllib.parse
ROOT = os.path.abspath(sys.argv[1] if len(sys.argv) > 1 else '.')
PORT = int(sys.argv[2]) if len(sys.argv) > 2 else 8765
POLLER = b"""<script>(function(){var f=location.pathname.split('/').pop();var last=null;setInterval(function(){fetch('/__mtime?f='+encodeURIComponent(f),{cache:'no-store'}).then(function(r){return r.json()}).then(function(j){if(last===null){last=j.mtime;return;}if(j.mtime!==last){last=j.mtime;location.reload();}}).catch(function(){});},700);})();</script>"""
class H(http.server.SimpleHTTPRequestHandler):
    def __init__(self, *a, **k): super().__init__(*a, directory=ROOT, **k)
    def log_message(self, fmt, *args): pass
    def do_GET(self):
        u = urllib.parse.urlparse(self.path)
        if u.path == '/__mtime':
            f = urllib.parse.parse_qs(u.query).get('f', [''])[0]; p = os.path.join(ROOT, os.path.basename(f))
            body = json.dumps({'mtime': os.path.getmtime(p) if os.path.exists(p) else 0}).encode()
            self.send_response(200); self.send_header('Content-Type', 'application/json'); self.send_header('Cache-Control', 'no-store'); self.send_header('Content-Length', str(len(body))); self.end_headers(); self.wfile.write(body); return
        if u.path.endswith('.html'):
            p = os.path.join(ROOT, u.path.lstrip('/'))
            if os.path.exists(p):
                data = open(p, 'rb').read(); i = data.rfind(b'</body>'); data = data[:i] + POLLER + data[i:] if i > 0 else data + POLLER
                self.send_response(200); self.send_header('Content-Type', 'text/html; charset=utf-8'); self.send_header('Cache-Control', 'no-store'); self.send_header('Content-Length', str(len(data))); self.end_headers(); self.wfile.write(data); return
        return super().do_GET()
if __name__ == '__main__':
    decks = [f for f in os.listdir(ROOT) if f.endswith('.html')]
    print('serving', ROOT, 'on http://localhost:%d/' % PORT, '→', ', '.join('http://localhost:%d/%s' % (PORT, d) for d in decks), flush=True)
    http.server.ThreadingHTTPServer(('0.0.0.0', PORT), H).serve_forever()
