defmodule Mix.Tasks.Pleroma.Email do
  use Mix.Task
  import Mix.Pleroma

  @shortdoc "Email administrative tasks"
  @moduledoc File.read!("docs/administration/CLI_tasks/email.md")

  def run(["test" | args]) do
    start_pleroma()

    {options, [], []} =
      OptionParser.parse(
        args,
        strict: [
          to: :string
        ]
      )

    email = Pleroma.Emails.AdminEmail.test_email(options[:to])
    {:ok, _} = Pleroma.Emails.Mailer.deliver(email)

    shell_info("Test email has been sent to #{inspect(email.to)} from #{inspect(email.from)}")
  end

  def run(["resend_confirmation_emails"]) do
    start_pleroma()

    shell_info("Sending emails to all unconfirmed users")

    Pleroma.User.Query.build(%{
      local: true,
      deactivated: false,
      confirmation_pending: true,
      invisible: false
    })
    |> Pleroma.Repo.chunk_stream(500)
    |> Stream.each(&Pleroma.User.try_send_confirmation_email(&1))
    |> Stream.run()
  end
end
