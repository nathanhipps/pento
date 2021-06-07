defmodule PentoWeb.WrongLive do
  use PentoWeb, :live_view

  def mount(_params, session, socket) do
    {
      :ok,
      assign(
        socket,
        score: 0,
        message: "Guess a number.",
        user: Pento.Accounts.get_user_by_session_token(session["user_token"]),
        session_id: session["live_socket_id"]
      )
    }
  end

  def render(assigns) do
    ~L"""
    <h1>Your score: <%= @score %></h1>
    <h2>
      <%= @message %>
    </h2>
    <h2>
      <%= for n <- 1..10 do %>
        <a href="#" phx-click="guess" phx-value-number="<%= n %>"><%= n %></a>
      <% end %>
    </h2>
    <pre> <%= @user.email %> <%= @session_id %> </pre>
    """
  end

  def handle_event("guess", %{"number" => guess} = data, socket) do
    IO.inspect data
    {
      :noreply,
      assign(
        socket,
        message: "Your guess: #{guess}. Wrong. Guess again. ",
        score: socket.assigns.score - 1
      )
    }
  end
end
