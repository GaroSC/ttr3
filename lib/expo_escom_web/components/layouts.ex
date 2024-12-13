defmodule ExpoEscomWeb.Layouts do
  @moduledoc """
  This module holds different layouts used by your application.

  See the `layouts` directory for all templates available.
  The "root" layout is a skeleton rendered as part of the
  application router. The "app" layout is set as the default
  layout on both `use ExpoEscomWeb, :controller` and
  `use ExpoEscomWeb, :live_view`.
  """
  use ExpoEscomWeb, :html

  import ExpoEscomWeb.Component.Breadcrumb
  import ExpoEscomWeb.Component.Button
  import ExpoEscomWeb.Component.DropdownMenu
  import ExpoEscomWeb.Component.Input
  import ExpoEscomWeb.Component.Menu
  import ExpoEscomWeb.Component.Sheet
  import ExpoEscomWeb.Component.Tooltip

  embed_templates "layouts/*"
end
