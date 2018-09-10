# foreman-container
A Dockerfile to build foreman in a container

After building/pulling the container, it can be started with:
```
docker run -d -p 3000:3000 foreman
```
After that you'll find foreman at http://127.0.0.1:3000/

Logging in can be done with admin/changeme
