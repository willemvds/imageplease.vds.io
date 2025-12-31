server {
	listen 80;
	server_name imageplease.vds.io;
	http2 on;
	return 301 https://$host$request_uri;
}

server {
	listen 443 ssl;
	listen 443 quic;
	server_name imageplease.vds.io;
	http2 on;
	http3 on;
	keepalive_timeout 70;

	add_header Alt-Svc 'h3=":443"; ma=86400';

	ssl_certificate /etc/letsencrypt/live/vds.io-0001/fullchain.pem;
	ssl_certificate_key /etc/letsencrypt/live/vds.io-0001/privkey.pem;

	root /home/imageplease.vds.io;
	index index.html;

	location / {
		sendfile on;
		sendfile_max_chunk 512k;
		tcp_nopush on;
		tcp_nodelay on;
		try_files $uri $uri/ =404;
		autoindex off;
	}
}

