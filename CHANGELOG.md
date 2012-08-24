# Changelog

## 0.6

* Added two new methods for easy customization of the controller's flow: `opinio_after_create_path` and `opinio_after_destroy_path`
* Changed default destroy conditions to false to prevent unsecure behaviour
* Complete change in the opinio model removing unnecessary validations and
  leaving all the options to the developer instead of using the engine
* Changed how `opinio_subjectum` handles the options passed, now letting you
  customize anything like you would in a `has_many` relationship


## 0.5

* Fixed i18n support (thanks [paxer](http://github.com/paxer))
* Added `strip_html_on_save` (thanks [paxer](http://github.com/paxer))
* Added `set_flash` option
* Added haml views (thanks [eicca](http://github.com/eicca))


## 0.4

* Moved shared examples so they can be used by the gem users
* Small refactoring on some specs
* Added a few specs to test `#{opinio_model}_destroy_conditions`
* Fixed small issues and added kaminari gem on the install generator


## 0.3.2

* Added specs for routing and controllers
* Added `respond_to` html format on create and destroy
