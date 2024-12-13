defmodule ExpoEscomWeb.Live.DashboardOne do
  use ExpoEscomWeb, :live_view

  import ExpoEscomWeb.Component.Badge
  import ExpoEscomWeb.Component.Button
  import ExpoEscomWeb.Component.Card
  import ExpoEscomWeb.Component.DropdownMenu
  import ExpoEscomWeb.Component.Menu
  import ExpoEscomWeb.Component.Skeleton
  import ExpoEscomWeb.Component.Table
  import ExpoEscomWeb.Component.Tabs

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, products: seed_products(10))}
  end

  defp seed_products(count) do
    Enum.map(1..count, fn _ ->
      %{
        id: 8 |> :crypto.strong_rand_bytes() |> Base.encode16(),
        name: Faker.Commerce.product_name(),
        status: Enum.random(~w[active draft]),
        price: Faker.Commerce.price(),
        total_sales: Enum.random(0..100),
        created_at: Faker.DateTime.between(~D[2023-01-01], ~D[2024-12-31])
      }
    end)
  end

  @impl true
  def render(assigns) do
    ~H"""
    <.tabs :let={builder} default="all" id="tabs">
      <div class="flex items-center">
        <.tabs_list>
          <.tabs_trigger value="all" builder={builder}>All</.tabs_trigger>
          <.tabs_trigger value="active" builder={builder}>Active</.tabs_trigger>
          <.tabs_trigger value="draft" builder={builder}>Draft</.tabs_trigger>
          <.tabs_trigger value="archived" builder={builder} class="hidden sm:flex">
            Archived
          </.tabs_trigger>
        </.tabs_list>
        <div class="ml-auto flex items-center gap-2">
          <.dropdown_menu>
            <.dropdown_menu_trigger>
              <.button variant="outline" size="sm" class="h-8 gap-1">
                <Lucideicons.beer class="h-3.5 w-3.5" />
                <span class="sr-only sm:not-sr-only sm:whitespace-nowrap">
                  Filter
                </span>
              </.button>
            </.dropdown_menu_trigger>
            <.dropdown_menu_content align="end">
              <.menu>
                <.menu_label>Filter by</.menu_label>
                <.menu_separator />
                <.menu_item>
                  Active
                </.menu_item>
                <.menu_item>Draft</.menu_item>
                <.menu_item>
                  Archived
                </.menu_item>
              </.menu>
            </.dropdown_menu_content>
          </.dropdown_menu>
          <.button size="sm" variant="outline" class="h-8 gap-1">
            <Lucideicons.beer class="h-3.5 w-3.5" />
            <span class="sr-only sm:not-sr-only sm:whitespace-nowrap">
              Export
            </span>
          </.button>
          <.button size="sm" class="h-8 gap-1">
            <Lucideicons.beer class="h-3.5 w-3.5" />
            <span class="sr-only sm:not-sr-only sm:whitespace-nowrap">
              Add Product
            </span>
          </.button>
        </div>
      </div>
      <.tabs_content value="all">
        <.card>
          <.card_header>
            <.card_title>Products</.card_title>
            <.card_description>
              Manage your products and view their sales performance.
            </.card_description>
          </.card_header>
          <.card_content>
            <.table>
              <.table_header>
                <.table_row>
                  <.table_head class="hidden w-[100px] sm:table-cell"></.table_head>
                  <.table_head>Name</.table_head>
                  <.table_head>Status</.table_head>
                  <.table_head class="hidden md:table-cell">
                    Price
                  </.table_head>
                  <.table_head class="hidden md:table-cell">
                    Total Sales
                  </.table_head>
                  <.table_head class="hidden md:table-cell">
                    Created at
                  </.table_head>
                  <.table_head>
                    <span class="sr-only">Actions</span>
                  </.table_head>
                </.table_row>
              </.table_header>
              <.table_body :for={product <- @products}>
                <.table_row>
                  <.table_cell class="hidden sm:table-cell">
                    <.skeleton class="h-16 w-16" />
                  </.table_cell>
                  <.table_cell class="font-medium">
                    {product.name}
                  </.table_cell>
                  <.table_cell>
                    <.badge variant="outline">{product.status}</.badge>
                  </.table_cell>
                  <.table_cell class="hidden md:table-cell">
                    ${product.price}
                  </.table_cell>
                  <.table_cell class="hidden md:table-cell">
                    {product.total_sales}
                  </.table_cell>
                  <.table_cell class="hidden md:table-cell">
                    {product.created_at |> Calendar.strftime("%Y-%m-%d %I:%M:%S %p")}
                  </.table_cell>
                  <.table_cell>
                    <.dropdown_menu>
                      <.dropdown_menu_trigger>
                        <.button aria-haspopup="true" size="icon" variant="ghost">
                          <Lucideicons.beer class="h-4 w-4" />
                          <span class="sr-only">Toggle menu</span>
                        </.button>
                      </.dropdown_menu_trigger>
                      <.dropdown_menu_content align="end">
                        <.menu>
                          <.menu_label>Actions</.menu_label>
                          <.menu_item>Edit</.menu_item>
                          <.menu_item>Delete</.menu_item>
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
              Showing <strong>1-10</strong> of <strong>32</strong> products
            </div>
          </.card_footer>
        </.card>
      </.tabs_content>
    </.tabs>
    """
  end
end
