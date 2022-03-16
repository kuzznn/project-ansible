const http = require('http');
const hostname = '192.168.56.10';
const port = 5000;

const server = http.createServer((req, res) => {
        res.statusCode = 200;
        res.setHeader('Content-Type', 'text/plain');
        res.end('Sysmon App is Up and Running!\n on gitlab.nma.local');
});

server.listen(port, hostname, () => {
        console.log(`Server running at http://${hostname}:${port}/`);
});