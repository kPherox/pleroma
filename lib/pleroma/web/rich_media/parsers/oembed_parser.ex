defmodule Pleroma.Web.RichMedia.Parsers.OEmbed do
  def parse(html, _data) do
    with elements = [_ | _] <- get_discovery_data(html),
         {:ok, oembed_url} <- get_oembed_url(elements),
         {:ok, oembed_data} <- get_oembed_data(oembed_url) do
      {:ok, oembed_data}
    else
      _e -> {:error, "No OEmbed data found"}
    end
  end

  defp get_discovery_data(html) do
    html |> Floki.find("link[type='application/json+oembed']")
  end

  defp get_oembed_url(nodes) do
    {"link", attributes, _children} = nodes |> hd()

    {:ok, Enum.into(attributes, %{})["href"]}
  end

  defp get_oembed_data(url) do
    {:ok, %Tesla.Env{body: json}} = Pleroma.HTTP.get(url)

    {:ok, Poison.decode!(json)}
  end
end