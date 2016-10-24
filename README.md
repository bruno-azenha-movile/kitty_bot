# KittyBot

To start your Phoenix app:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `npm install`
  * Start Phoenix endpoint with `mix phoenix.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Original Creation Guide
This bot was created during one of Movile's Elixir/Phoenix meetings. It was created
in about 1.5h and is full of kitties and puppies. Below you'll find the file that
was a roadmap for this bot's creation.


Hello There!

So I heard that you have just completed the Phoenix guide for getting a web
application running on Heroku:

http://www.phoenixframework.org/docs/heroku

Now you have this super cool blank canvas application and have no idea of what
to do with it? Here's a good idea: Let's Build a Facebook Messenger Chatbot!

What we actually will build is a simple Echo bot: A chatbot that repeats
whatever it is told, but we will also cover what is necessary to build all the
fancy message formats that messenger messages can take.

Here are the things you'll need:

* Working Blank Phoenix Web Application on Heroku
* Facebook Page for the broadcast
* Facebook Developer account (it's freeeee)
* Postman for testing with fake messages

Installing dependencies

In order to help us with the facebook authentication and interface with their
api, we are going to use a phoenix library:

https://github.com/Bilue/phoenix_facebook_messenger

we have to add both dependencies to our on mix.exs file:

```
defp deps do
  [
    ...
    {:httpotion, "~> 3.0.2"},
    {:phoenix_facebook_messenger, git: "https://github.com/Bilue/phoenix_facebook_messenger.git"},
    ...
  ]
end

def application do
  [ applications: [:httpotion] ]
end
```

For the facebook messenger dependency to work, we have to add a controller and
the corresponding routes to the controller. We'll start with the samples
provided by the dependency README:

New Controller: bot_controller.ex
```
defmodule KittyBotComplete.BotController do
  use FacebookMessenger.Phoenix.Controller

  def message_received(msg) do
    text = FacebookMessenger.Response.message_texts(msg) |> hd
    sender = FacebookMessenger.Response.message_senders(msg) |> hd
    FacebookMessenger.Sender.send(sender, text)
  end
end
```

Add those two lines to router.ex:
```
use FacebookMessenger.Phoenix.Router
facebook_routes "/api/webhook", KittyBotComplete.BotController
```

Now that we have the dependency installation sorted out, we need to connect our
application to the Facebook page.

For that, create a new Application on the facebook developers' website. Select
the basic setup option, it will prompt you for a page name and to confirm your
email. Then select the Messenger Platform integration. From there, select the
page to which you wish your bot to answer for and generate the Page Access
Token. With this token you will already be able to send messages through your
bot.

Just as you have configured Phoenix to use Heroku's environment variables, we
will to use heroku's env vars to store our bot's secret keys. For that, we first
create the new variable on heroku:

```
heroku config:set SECRET_KEY_BASE="<YOUR_PAGE_ACCESS_KEY>"
```

Then generate another key to be your webhook verify token
```
mix phoenix.gen.secret
<generates a key>
heroku config:set FB_VERIFICATION_TOKEN="<key>"
```

Now we will tell the facebook messenger dependency  where to look for these
configurations:

On config.exs add:
```
config :facebook_messenger,
    facebook_page_token: System.get_env("FB_PAGE_ACCESS_TOKEN"),
    challenge_verification_token: System.get_env("FB_VERIFICATION_TOKEN")
```

After all that, commit your changes and push to heroku master.

We sould be able to authenticate our bot's webhook on facebook developers page.
After verifying the webhook, DO NOT FORGET to actually subscribe your webhook to
the page, otherwise you'll just feel silly trying to get your bot to answer you.

Ok, so we got an EchoBot! But I guess we want to make a lot of more interesting
things.

------------------
Expanding and testing locally
** There is a very ugly bug on the FacebookMessenger library. that breaks debug
level logs, so to be able to run locally, we actually have to disable those logs
The plan is to eventually grow our own superior Movile bot library and maintain
it. That'd be great. :)

Do remember to set the FB_PAGE_ACCESS_TOKEN locally:

```
export FB_PAGE_ACCESS_TOKEN=<YOUR_FB_PAGE_ACCESS_TOKEN>
```

To make it easier for us to test, I have prepared a file with some common
messages formats that will be received by the bot. Once you figure out what your
fbid is, you can use it with requests to your local bot and it will actually
send the responses directly to FB messenger.

0th expansion: Configure Persistent Menu and Get Started button

1st expansion: Add response text for get started button.

2st expansion: Change Get Started to return something other than a simple text.

3rd expansion: Connect to an external api!

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
