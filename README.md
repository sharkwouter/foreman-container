# foreman-container
A simple container which launches the stable version of Foreman. It uses SQLite3 as database and runs Foreman unencrypted, making it not suitable for a production system. The credentials are:

| User  | Pass     |
|-------|----------|
| admin | changeme |

The container can be started with:
```
docker run -d -p 3000:3000 sharkwouter/foreman
```
After starting, Foreman can be found at: [http://127.0.0.1:3000/]
