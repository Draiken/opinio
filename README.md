# Opinio #
[![Travis-CI](https://secure.travis-ci.org/Draiken/opinio.png?branch=master)](https://travis-ci.org/Draiken/opinio) [![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/Draiken/opinio)

**IMPORTANT** Version 0.6 might break some behaviour from 0.5 and lower versions, please refer to the [changelog](https://github.com/Draiken/opinio/blob/master/CHANGELOG.rdoc)

## Description ##

Opinio is an engine used to add comments behaviour to your application.
The engine is designed to work only with **Rails 3**

## Intallation ##

Simply add the following line to your *Gemfile*:

    gem "opinio"

and run:

    bundle

## Usage ##

Opinio provides generators to facilitate it's usage.
The most common way to quickly get Opinio working is:

    rails g opinio:install comment

This will generate the `Comment` model, migration and also generate the opinio initializer for customization of the engine.
A `opinio_model` will be added on the `routes.rb`. This method adds the default urls for the model that will act as the comment
in your app.

In order to add the comments functionality to a model, you use the `opinio_subjectum` method

    class Post < ActiveRecord::Base
      opinio_subjectum
    end

On the `routes.rb` you should simply add an `opinio` for your commentable resource

    resources :posts do
      opinio
    end

To render the comments in your views, there is a helper to display the resource's comments easily:

    <%= comments_for @post %>

This will render the comments and a form for new comment submissions. Alternatively you can render just the comments or just the form like this:

    <%= render_comments @post %>
    <%= render_comments_form @post %>

If you need to render the comments with a specific page or limit
you can use Kaminari's configurations like `paginates_per 10` on your comment model
or you can customize it for specific views on the helpers

    <%= render_comments @post, :page => params[:page], :limit => 5 %>

This options can also be used on the `comments_for` helper.

## Customization ##

### Views ###

Of course you will want to customize how the comments are displayed or any other customization to the view. To generate the view files on your application, run:

    rails g opinio:views

And you can customize all the views used by the engine.

### Behaviour ###

#### Opinio Model ####

You can customize the opinio model to suit your needs. The basic customization is the owner class name. It defaults to `User` but you can change that in the initializer or in the model by passing the `:owner_class_name => "MyOwnerClass"` option to the `opinio_model` method call.

Another customization you can do is set the `counter_cache` to true in the commentable model. You can use the `:counter_cache` option for that.

The other two customizations are only made through the initializer, and they are the `accept_replies` which defaults to true and `strip_html_tags_on_save` which also defaults to `true`.

Validations on the opinio model are very basic, just ensuring it has a body, a commentable and an owner, if you want any other kind of validation, like the minimum size of a comment, you can use the regular AR validations as you wish.

Remember that if you use titles, you need to add that to your comments table, since the generator doesn't add it by default.

#### Opinio Subjectum ####

To change how the models that actually have the comments, you can customize them with any option you would use to a regular `has_many` relationship in ActiveRecord.

The default options are these:

      has_many :comments,
               :class_name => Opinio.model_name,
               :as => :commentable,
               :order => "created_at #{Opinio.sort_order}"),
               :dependent => :destroy

The `sort_order` and `model_name` are both setup in the initializer. Here you can do things like, let's say you have moderation in your comments, you can only show the approved comments:

    opinio_subjectum :conditions => ["approved = ?", true]

Remember you can override any of these options (except `as`) by passing them to the `opinio_subjectum` method.

#### Pretty Urls ####

Often times you will want the engine to show the index of comments for a specific item
without having to pass the `:commentable_type` or `:commentable_id` parameters.

In order to do that, opinio provides a method to `ActionController::Base`:

    opinio_identifier do |params|
      next Review.find(params[:review_id]) if params[:review_id]
      next Product.find(params[:product_id]) if params[:product_id]
    end

Note: you use next instead of return because it is a proc that will be executed later on, and you cannot return on procs

Basically on this method you receive the `params` variable and you tell the engine, who owns
the comments from that page.
This allows you to use routes like:

    /products/1/comments
    /products/1/reviews/1/comments

Without passing those 2 parameters.
I suggest you put this method on the `ApplicationController`

#### Customize destroy conditions ####

By default, noone can destroy a comment in the engine. You have to tell the engine who can do it.
To setup a custom destroy condition use the methods provided by opinio
in our controllers. For instance, if our opinio model is called 'comment' 
it could be written like this:

    comment_destroy_conditions do |comment|
      comment.owner == current_user
    end

This would make users only be able to remove their own comments.
Another example would be using the `CanCan`:

    comment_destroy_conditions do |comment|
      authorize :destroy, comment
    end

You get the picture, you're inside your controller's methods on that block
so you can call anything your normal controllers call on actions.

### Testing ###

Opinio provides a few shared examples for testing of your model with rspec
On your opinio model test case you can require opinio's shared examples and use them

    require 'opinio/shared_examples'

    describe Comment do
      it_should_behave_like :opinio
    end

    describe Post do
      it_should_behave_like :opinio_subjectum
    end

## Contribution ##

If you want to help in any way with **Opinio** please message me or fork the project, make the changes and send me a pull request.
For issues please use the github [issues tracker](https://github.com/Draiken/opinio/issues)

### TODO ###

  * Refactor the `comments_for` helper
  * Extract documentation to wiki
  * Add mongoid support
