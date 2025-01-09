defmodule ExpoEscomWeb.EventoLive.Index do
  use ExpoEscomWeb, :live_view

  import ExpoEscomWeb.CoreComponents

  @impl true
  def render(assigns) do
    ~H"""
    <.header>
      Listing Eventos
      <:actions>
        <.link patch={~p"/eventos/new"}>
          <.button>New Evento</.button>
        </.link>
      </:actions>
    </.header>

    <.table
      id="eventos"
      rows={@streams.eventos}
      row_click={fn {_id, evento} -> JS.navigate(~p"/eventos/#{evento}") end}
    >
      <:col :let={{_id, evento}} label="Id">{evento.id}</:col>

      <:col :let={{_id, evento}} label="Nombre">{evento.nombre}</:col>

      <:col :let={{_id, evento}} label="Descripcion">{evento.descripcion}</:col>

      <:col :let={{_id, evento}} label="Ano">{evento.ano}</:col>

      <:col :let={{_id, evento}} label="Color fondo">{evento.color_fondo}</:col>

      <:col :let={{_id, evento}} label="Url cartel">{evento.url_cartel}</:col>

      <:action :let={{_id, evento}}>
        <div class="sr-only">
          <.link navigate={~p"/eventos/#{evento}"}>Show</.link>
        </div>

        <.link patch={~p"/eventos/#{evento}/edit"}>Edit</.link>
      </:action>

      <:action :let={{id, evento}}>
        <.link
          phx-click={JS.push("delete", value: %{id: evento.id}) |> hide("##{id}")}
          data-confirm="Are you sure?"
        >
          Delete
        </.link>
      </:action>
    </.table>

    <.modal
      :if={@live_action in [:new, :edit]}
      id="evento-modal"
      show
      on_cancel={JS.patch(~p"/eventos")}
    >
      <.live_component
        module={ExpoEscomWeb.EventoLive.FormComponent}
        id={(@evento && @evento.id) || :new}
        title={@page_title}
        current_user={@current_user}
        action={@live_action}
        evento={@evento}
        patch={~p"/eventos"}
      />
    </.modal>
    """
  end

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> stream(
       :eventos,
       Ash.read!(ExpoEscom.Eventos.Evento, actor: socket.assigns[:current_user])
     )
     |> assign_new(:current_user, fn -> nil end)}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Evento")
    |> assign(:evento, Ash.get!(ExpoEscom.Eventos.Evento, id, actor: socket.assigns.current_user))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Evento")
    |> assign(:evento, nil)
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Eventos")
    |> assign(:evento, nil)
  end

  @impl true
  def handle_info({ExpoEscomWeb.EventoLive.FormComponent, {:saved, evento}}, socket) do
    {:noreply, stream_insert(socket, :eventos, evento)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    evento = Ash.get!(ExpoEscom.Eventos.Evento, id, actor: socket.assigns.current_user)
    Ash.destroy!(evento, actor: socket.assigns.current_user)

    {:noreply, stream_delete(socket, :eventos, evento)}
  end
end
