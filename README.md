jenkins-deployment-example
==========================

Shows you how to create the scripts needed for automated deployment.

### Project dependencies installing

If you have any dependencies, which installation depends on files from project, you should add these files and installation commands into your new `Dockerfile`. Then you will be able to use Docker magic - command caching. If your project dependency files won't change, it won't be needed to install these dependencies again, and thus it will noticeably speed up your builds.

Project dependency files example:

  - `.npmrc`
  - `.npmignore`
  - `package.json`
  - `.bowerrc`
  - `bower.json`
  
If you need another file, you must also add its path to `.docker-cache` file in root directory, so the caching feature works correctly.
  
Add command example:

  - `ADD code/server/package.json /srv/project/code/server/package.json`
  
Install command example:

  - `RUN (cd /srv/project/code/server && npm install)`
