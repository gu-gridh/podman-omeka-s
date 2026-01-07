# podman-omeka-s
Rootless podman version that works for several Omeka-S projects at the same time.

## First installation

- Create secret files for the database:
  - Create 2 normal text files per project that contain the passwords as one line. One for the unpriviledged user and one for the root user. The names for these users are already defined in the docker file, so only the password needs to be provided.
  - Name these files according to the constraint: `<project>-mysql-pw` and `<project>-mysql-root-pw` and save them to base/secrets/ (they will then be ignored via gitignore).
  - Run `podman secret create <project>-mysql-root-pw base/secrets/<project>-mysql-root-pw` and `podman secret create <project>-mysql-pw base/secrets/<project>-mysql-pw` (replace <project> with the project name and adjust base/... to a full path if you don't run this command from the root of this repository)
- Add a `.env` file per project (at /instance/project/) similar like this:
```
ENV_PORTS="8081:80"
ENV_DB_PORTS="3301:3306"
ENV_VOLUME="my/files:/var/www/html/files:Z,U"
```
Change the first part of the ports according to your wishes where you want your webserver port and database port from the container for that project should be exposed on your local system. And change the first part of the volume where you want the files to be stored.
- Add the config folder for each instance with the local.config.php file just like this one: https://github.com/omeka/omeka-s/blob/develop/config/local.config.php.dist
- Build and run the container:
  - Run `podman-compose build` (use `--no-cache` if needed) for a project in it's instance folder
  - If everything exists successfully, run `podman-compose up` and you should find the project at localhost:8081 (or whichever port you chose)
- Add database:
  - It's easiest to run the container and copy the dump file from the host into the container with: `podman cp dump.sql <project>-db:/tmp/dump.sql` (replace <project> with the project name)
  - Then enter the database container with `podman exec -it <project>-db bash` (replace <project> with the project name)
  - Inside the container run `mariadb -h localhost -u root -p <project> < /tmp/dump.sql` and enter the db password (you find it in your secret file)
- Add files:
  - just add them where your volume is mounted. But beware file permissions

## When everything is running

- Just do `podman-compose up` for starting and `podman-compose down` for stopping the container within the instance folder of the project you want to start
- If something behaves weirdly during start up and says that it can't start: Are you sure you stopped a former container? Run down once more to make sure.
- If there is an update: Run build again
- If the database got an update: Add the db again just like during the first installation (it will overwrite the existing one)




