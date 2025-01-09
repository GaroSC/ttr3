defmodule ExpoEscomWeb.ActividadLive.FormComponent do
  use ExpoEscomWeb, :live_component

  import ExpoEscomWeb.CoreComponents

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        {@title}
        <:subtitle>Use this form to manage actividad records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="actividad-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:nombre]} type="text" label="Nombre" />

        <:actions>
          <.button phx-disable-with="Saving...">Save Actividad</.button>
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
  def handle_event("validate", %{"actividad" => actividad_params}, socket) do
    {:noreply,
     assign(socket, form: AshPhoenix.Form.validate(socket.assigns.form, actividad_params))}
  end

  def handle_event("save", %{"actividad" => actividad_params}, socket) do
    case AshPhoenix.Form.submit(socket.assigns.form, params: actividad_params) do
      {:ok, actividad} ->
        notify_parent({:saved, actividad})

        socket =
          socket
          |> put_flash(:info, "Actividad #{socket.assigns.form.source.type}d successfully")
          |> push_patch(to: socket.assigns.patch)

        {:noreply, socket}

      {:error, form} ->
        {:noreply, assign(socket, form: form)}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})

  defp assign_form(%{assigns: %{actividad: actividad}} = socket) do
    form =
      if actividad do
        AshPhoenix.Form.for_update(actividad, :update,
          as: "actividad",
          actor: socket.assigns.current_user
        )
      else
        AshPhoenix.Form.for_create(ExpoEscom.Eventos.Actividad, :create,
          as: "actividad",
          actor: socket.assigns.current_user
        )
      end

    assign(socket, form: to_form(form))
  end
end
