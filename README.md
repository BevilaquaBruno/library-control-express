# Libray control project
  > this projet use:

  - [Express](expressjs.com)
  - [CouchDb](couchdb.apache.org)
  - [Sass](sass-lang.com)
  - [CoffeeScript](coffeescript.org)

  ###### All the files in external/coffee are compiled to .js

  ###### All the files in external/sass are compile to .css in public/stylesheets

  The commands in package.json:

  - Compile the .scss to .css files:
  ```
  npm run-script sass-compile
  ```

  - compile all the .coffee files to .js:
  ```
  npm run-script coffee-compile
  ```

  - compile the sass when some changes are detected
    ```
    npm run-script sass-compile-watch
    ```

  - compile the .coffee when some changes are detected
  ```
  npm run-script coffee-compile-watch
  ```
