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
      "CMD_GET_STARTED" -> FacebookMessenger.Sender.send(sender, "Você Apertou o GET STARTED")
      _ -> {:ok}
    end
  end
end
