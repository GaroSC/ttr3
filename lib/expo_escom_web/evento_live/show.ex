defmodule ExpoEscomWeb.EventoLive.Show do
  use ExpoEscomWeb, :live_view

  import ExpoEscomWeb.CoreComponents

  @impl true
  def render(assigns) do
    ~H"""
    <.header>
      Evento {@evento.id}
      <:subtitle>This is a evento record from your database.</:subtitle>

      <:actions>
        <.link patch={~p"/eventos/#{@evento}/show/edit"} phx-click={JS.push_focus()}>
          <.button>Edit evento</.button>
        </.link>
      </:actions>
    </.header>

    <.list>
      <:item title="Id">{@evento.id}</:item>

      <:item title="Nombre">{@evento.nombre}</:item>

      <:item title="Descripcion">{@evento.descripcion}</:item>

      <:item title="Ano">{@evento.ano}</:item>

      <:item title="Color fondo">{@evento.color_fondo}</:item>

      <:item title="Url cartel">{@evento.url_cartel}</:item>
    </.list>

    <.back navigate={~p"/eventos"}>Back to eventos</.back>

    <.modal
      :if={@live_action == :edit}
      id="evento-modal"
      show
      on_cancel={JS.patch(~p"/eventos/#{@evento}")}
    >
      <.live_component
        module={ExpoEscomWeb.EventoLive.FormComponent}
        id={@evento.id}
        title={@page_title}
        action={@live_action}
        current_user={@current_user}
        evento={@evento}
        patch={~p"/eventos/#{@evento}"}
      />
    </.modal>
    """
  end

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(
       :evento,
       Ash.get!(ExpoEscom.Eventos.Evento, id, actor: socket.assigns.current_user)
     )}
  end

  defp page_title(:show), do: "Show Evento"
  defp page_title(:edit), do: "Edit Evento"
end
