# Library control project
  > this projet use:

  - [Express](http://expressjs.com/pt-br/)
  - [CouchDb](http://couchdb.apache.org/)
  - [Sass](https://sass-lang.com/)
  - [CoffeeScript](https://coffeescript.org/)
  - [Pugjs](https://pugjs.org/api/getting-started.html)

### How to run

- First install [couchdb](http://couchdb.apache.org/#download)
- Clone this repo
- Run ``` cd library-control-express ```
- Run ``` npm install ```
- Run ``` npm run-script coffee-compile && npm run-script sass-compile```
- Run ``` npm run-script nodemon ```
- Access [http://localhost:3000](http://localhost:3000)

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
