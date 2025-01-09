defmodule ExpoEscomWeb.EventoLive.FormComponent do
  use ExpoEscomWeb, :live_component

  import ExpoEscomWeb.CoreComponents

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        {@title}
        <:subtitle>Use this form to manage evento records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="evento-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:nombre]} type="text" label="Nombre" /><.input
          field={@form[:descripcion]}
          type="text"
          label="Descripcion"
        /><.input field={@form[:ano]} type="number" label="Ano" /><.input
          field={@form[:color_fondo]}
          type="text"
          label="Color fondo"
        /><.input field={@form[:url_cartel]} type="text" label="Url cartel" />

        <:actions>
          <.button phx-disable-with="Saving...">Save Evento</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_form()}
  end

  @impl true
  def handle_event("validate", %{"evento" => evento_params}, socket) do
    {:noreply, assign(socket, form: AshPhoenix.Form.validate(socket.assigns.form, evento_params))}
  end

  def handle_event("save", %{"evento" => evento_params}, socket) do
    case AshPhoenix.Form.submit(socket.assigns.form, params: evento_params) do
      {:ok, evento} ->
        notify_parent({:saved, evento})

        socket =
          socket
          |> put_flash(:info, "Evento #{socket.assigns.form.source.type}d successfully")
          |> push_patch(to: socket.assigns.patch)

        {:noreply, socket}

      {:error, form} ->
        {:noreply, assign(socket, form: form)}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})

  defp assign_form(%{assigns: %{evento: evento}} = socket) do
    form =
      if evento do
        AshPhoenix.Form.for_update(evento, :update,
          as: "evento",
          actor: socket.assigns.current_user
        )
      else
        AshPhoenix.Form.for_create(ExpoEscom.Eventos.Evento, :create,
          as: "evento",
          actor: socket.assigns.current_user
        )
      end

    assign(socket, form: to_form(form))
  end
end
