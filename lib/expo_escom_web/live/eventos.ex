defmodule ExpoEscomWeb.Live.Eventos do
  use ExpoEscomWeb, :live_view

  import ExpoEscomWeb.Component.Button
  import ExpoEscomWeb.Component.Card
  import ExpoEscomWeb.Component.DropdownMenu
  import ExpoEscomWeb.Component.Menu
  import ExpoEscomWeb.Component.Skeleton
  import ExpoEscomWeb.Component.Table
  import ExpoEscomWeb.Component.Tabs

  import ExpoEscomWeb.Component.Dialog
  import ExpoEscomWeb.Component.Input
  import ExpoEscomWeb.Component.Label
  import ExpoEscomWeb.Component.Textarea

  alias ExpoEscom.Eventos.Evento

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, eventos: get_eventos())}
  end

  defp get_eventos() do
    Ash.read!(Evento)
  end

  @impl true
  def render(assigns) do
    ~H"""
    <.tabs default="all" id="tabs">
      <div class="flex items-center">
        <div class="ml-auto flex items-center gap-2">
          <.button size="sm" class="h-8 gap-1">
            <Lucideicons.beer class="h-3.5 w-3.5" />
            <span
              class="sr-only sm:not-sr-only sm:whitespace-nowrap"
              phx-click={show_modal("agregar-modal")}
            >
              Agregar Evento
            </span>
          </.button>
        </div>
      </div>
      <.tabs_content value="all">
        <.card>
          <.card_header>
            <.card_title>Eventos</.card_title>
            <.card_description>
              Maneja los eventos existentes
            </.card_description>
          </.card_header>
          <.card_content>
            <.table>
              <.table_header>
                <.table_row>
                  <.table_head class="hidden w-[100px] sm:table-cell"></.table_head>
                  <.table_head>Nombre</.table_head>
                  <.table_head>Descripcion</.table_head>
                  <.table_head class="hidden md:table-cell">
                    Año
                  </.table_head>
                  <.table_head class="hidden md:table-cell">
                    Color
                  </.table_head>
                  <.table_head class="hidden md:table-cell">
                    Cartel
                  </.table_head>
                  <.table_head>
                    <span class="sr-only">Acciones</span>
                  </.table_head>
                </.table_row>
              </.table_header>
              <.table_body :for={evento <- @eventos}>
                <.table_row>
                  <.table_cell class="hidden sm:table-cell">
                    <.skeleton class="h-16 w-16" />
                  </.table_cell>
                  <.table_cell class="font-medium">
                    {evento.nombre}
                  </.table_cell>
                  <.table_cell>
                    {evento.descripcion}
                  </.table_cell>
                  <.table_cell class="hidden md:table-cell">
                    {evento.ano}
                  </.table_cell>
                  <.table_cell class="hidden md:table-cell">
                    {evento.color_fondo}
                  </.table_cell>
                  <.table_cell class="hidden md:table-cell">
                    {evento.url_cartel}
                  </.table_cell>
                  <.table_cell>
                    <.dropdown_menu>
                      <.dropdown_menu_trigger>
                        <.button aria-haspopup="true" size="icon" variant="ghost">
                          <Lucideicons.beer class="h-4 w-4" />
                          <span class="sr-only">Mostrar menu</span>
                        </.button>
                      </.dropdown_menu_trigger>
                      <.dropdown_menu_content align="end">
                        <.menu>
                          <.menu_label>Acciones</.menu_label>
                          <.menu_item>Editar</.menu_item>
                          <.menu_item>Eliminar</.menu_item>
                        </.menu>
                      </.dropdown_menu_content>
                    </.dropdown_menu>
                  </.table_cell>
                </.table_row>
              </.table_body>
            </.table>
          </.card_content>
          <.card_footer>
            <div class="text-xs text-muted-foreground">
              Mostrando un total de <strong>{length(@eventos)}</strong> eventos
            </div>
          </.card_footer>
        </.card>
      </.tabs_content>
    </.tabs>

    <.dialog id="agregar-modal" on_cancel={hide_modal("agregar-modal")} class="w-[700px]">
      <.dialog_header>
        <.dialog_title>Crear Evento</.dialog_title>
      </.dialog_header>
      <div class="grid gap-4 py-4">
        <div class="grid grid-cols-4 items-center gap-4">
          <.label for="name" class="text-right">
            Nombre
          </.label>
          <.input id="name" value="Dzung Nguyen" class="col-span-3" />
        </div>
        <div class="grid grid-cols-4 items-center gap-4">
          <.label for="descripcion" class="text-right">
            Descripcion
          </.label>
          <.textarea id="descripcion" placeholder="Escribe una descripcion aqui" class="col-span-3" />
        </div>
        <div class="grid grid-cols-4 items-center gap-4">
          <.label for="ano" class="text-right">
            Año
          </.label>
          <.input
            id="ano"
            type="number"
            min="1900"
            max="2099"
            step="1"
            value="2024"
            class="col-span-3"
          />
        </div>
        <div class="grid grid-cols-4 items-center gap-4">
          <.label for="color_fondo" class="text-right">
            Color
          </.label>
          <.input id="color_fondo" type="color" class="col-span-3" />
        </div>
        <div class="grid grid-cols-4 items-center gap-4">
          <.label for="url_cartel" class="text-right">
            URL de Cartel
          </.label>
          <.input id="url_cartel" class="col-span-3" />
        </div>
      </div>
      <.dialog_footer>
        <.button variant="secondary" phx-click={hide_modal("agregar-modal")}>Cancelar</.button>
        <.button type="submit">Crear</.button>
      </.dialog_footer>
    </.dialog>
    """
  end
end
