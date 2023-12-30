defmodule InsigniaNotifyAppWeb.Shared.Footer.FooterComponent do
  use Phoenix.Component

  def footer(assigns) do
    ~H"""
    <footer class="flex flex-col w-full mt-5 mx-auto bg-gray-600 pt-4 pb-10 lg:py-4 px-4 lg:px-10 text-white font-chakra">
      Xbox and Xbox Live are registered trademarks of the Microsoft Corporation. <br />Insignia is
      neither endorsed by nor affiliated with Microsoft. <br />InsigniaNotify is neither endorsed by
      nor affiliated with Microsoft or Insignia Developer Team. <br />

      <a href="https://insignia.live/" target="_blank" class="mt-5">Insignia Website</a>
      <a href="https://discord.com/invite/CWkdVdc" target="_blank">Insignia Discord</a>
    </footer>
    """
  end
end
