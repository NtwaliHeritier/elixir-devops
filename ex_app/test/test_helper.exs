if System.get_env("CI") == "true" do
  ExUnit.configure(formatters: [JUnitFormatter])
end

ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(ExApp.Repo, :manual)
