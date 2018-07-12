# Libray control project
  > this projet use:

  - [Express](http://expressjs.com/pt-br/)
  - [CouchDb](http://couchdb.apache.org/)
  - [Sass](https://sass-lang.com/)
  - [CoffeeScript](https://coffeescript.org/)
  - [Pugjs](https://pugjs.org/api/getting-started.html)

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
