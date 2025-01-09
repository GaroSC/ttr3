defmodule ExpoEscomWeb.ActividadLive.Index do
  use ExpoEscomWeb, :live_view

  import ExpoEscomWeb.CoreComponents

  @impl true
  def render(assigns) do
    ~H"""
    <.header>
      Listing Actividades
      <:actions>
        <.link patch={~p"/actividades/new"}>
          <.button>New Actividad</.button>
        </.link>
      </:actions>
    </.header>

    <.table
      id="actividades"
      rows={@streams.actividades}
      row_click={fn {_id, actividad} -> JS.navigate(~p"/actividades/#{actividad}") end}
    >
      <:col :let={{_id, actividad}} label="Id">{actividad.id}</:col>

      <:col :let={{_id, actividad}} label="Nombre">{actividad.nombre}</:col>

      <:action :let={{_id, actividad}}>
        <div class="sr-only">
          <.link navigate={~p"/actividades/#{actividad}"}>Show</.link>
        </div>

        <.link patch={~p"/actividades/#{actividad}/edit"}>Edit</.link>
      </:action>

      <:action :let={{id, actividad}}>
        <.link
          phx-click={JS.push("delete", value: %{id: actividad.id}) |> hide("##{id}")}
          data-confirm="Are you sure?"
        >
          Delete
        </.link>
      </:action>
    </.table>

    <.modal
      :if={@live_action in [:new, :edit]}
      id="actividad-modal"
      show
      on_cancel={JS.patch(~p"/actividades")}
    >
      <.live_component
        module={ExpoEscomWeb.ActividadLive.FormComponent}
        id={(@actividad && @actividad.id) || :new}
        title={@page_title}
        current_user={@current_user}
        action={@live_action}
        actividad={@actividad}
        patch={~p"/actividades"}
      />
    </.modal>
    """
  end

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> stream(
       :actividades,
       Ash.read!(ExpoEscom.Eventos.Actividad, actor: socket.assigns[:current_user])
     )
     |> assign_new(:current_user, fn -> nil end)}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Actividad")
    |> assign(
      :actividad,
      Ash.get!(ExpoEscom.Eventos.Actividad, id, actor: socket.assigns.current_user)
    )
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Actividad")
    |> assign(:actividad, nil)
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Actividades")
    |> assign(:actividad, nil)
  end

  @impl true
  def handle_info({ExpoEscomWeb.ActividadLive.FormComponent, {:saved, actividad}}, socket) do
    {:noreply, stream_insert(socket, :actividades, actividad)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    actividad = Ash.get!(ExpoEscom.Eventos.Actividad, id, actor: socket.assigns.current_user)
    Ash.destroy!(actividad, actor: socket.assigns.current_user)

    {:noreply, stream_delete(socket, :actividades, actividad)}
  end
end
