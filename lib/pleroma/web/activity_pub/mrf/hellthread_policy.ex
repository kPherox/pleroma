# Pleroma: A lightweight social networking server
# Copyright © 2017-2019 Pleroma Authors <https://pleroma.social/>
# SPDX-License-Identifier: AGPL-3.0-only

defmodule Pleroma.Web.ActivityPub.MRF.HellthreadPolicy do
  alias Pleroma.User
  @behaviour Pleroma.Web.ActivityPub.MRF

  defp delist_message(object) do
    follower_collection = User.get_by_ap_id(object["actor"].follower_address)

    object
    |> Kernel.update_in(["to"], [follower_collection])
    |> Kernel.update_in(["cc"], ["https://www.w3.org/ns/activitystreams#Public"])
  end

  @impl true
  def filter(%{"type" => "Create"} = object) do
    delist_threshold = Pleroma.Config.get([:mrf_hellthread, :delist_threshold])

    reject_threshold =
      Pleroma.Config.get(
        [:mrf_hellthread, :reject_threshold],
        Pleroma.Config.get([:mrf_hellthread, :threshold])
      )

    recipients = (object["to"] || []) ++ (object["cc"] || [])

    cond do
      length(recipients) > reject_threshold and reject_threshold > 0 ->
        {:reject, nil}

      length(recipients) > delist_threshold and delist_threshold > 0 ->
        if Enum.member?(object["to"], "https://www.w3.org/ns/activitystreams#Public") or
             Enum.member?(object["to"], "https://www.w3.org/ns/activitystreams#Public") do
          delist_message(object)
          {:ok, object}
        else
          {:ok, object}
        end

      true ->
        {:ok, object}
    end
  end

  @impl true
  def filter(object), do: {:ok, object}
end
