defmodule KittyBot.BotController do
  use FacebookMessenger.Phoenix.Controller

  def message_received(msg) do
    text = FacebookMessenger.Response.message_texts(msg) |> hd
    sender = FacebookMessenger.Response.message_senders(msg) |> hd
    postback = FacebookMessenger.Response.message_postback(msg) |> hd

    handle_postback(sender, postback)
    FacebookMessenger.Sender.send(sender, text)
  end

  defp handle_postback(sender, postback) do
    case postback do
      "CMD_GET_STARTED" -> FacebookMessenger.Sender.send_template(sender, create_carroussel)
      "CMD_HELP" -> FacebookMessenger.Sender.send(sender, "AJUDAAAAA")
      _ -> {:ok}
    end
  end

  defp create_carroussel() do
    carroussel = [
      %{title: "Puppy",
      image_url: "http://cdn3-www.dogtime.com/assets/uploads/gallery/30-impossibly-cute-puppies/impossibly-cute-puppy-30.jpg",
      buttons: [ create_payload_button("More Cats!", "CMD_GET_STARTED") ]
      },
      %{title: "Puppy",
      image_url: "http://cdn3-www.dogtime.com/assets/uploads/gallery/30-impossibly-cute-puppies/impossibly-cute-puppy-30.jpg",
      buttons: [ create_payload_button("More Cats!", "CMD_GET_STARTED") ]
      },
      %{title: "Puppy",
      image_url: "http://cdn3-www.dogtime.com/assets/uploads/gallery/30-impossibly-cute-puppies/impossibly-cute-puppy-30.jpg",
      buttons: [ create_payload_button("More Cats!", "CMD_GET_STARTED") ]
      },
      %{title: "Puppy",
      image_url: "http://cdn3-www.dogtime.com/assets/uploads/gallery/30-impossibly-cute-puppies/impossibly-cute-puppy-30.jpg",
      buttons: [ create_payload_button("More Cats!", "CMD_GET_STARTED") ]
      }]
  end

  defp create_payload_button(title, payload) do
    %{
      type: "postback",
      title: title,
      payload: payload
    }
  end

end
