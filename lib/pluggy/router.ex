defmodule Pluggy.Router do
  use Plug.Router

  alias Pluggy.PageLoader
  alias Pluggy.UserController
  alias Pluggy.AdminController
  alias Pluggy.TeacherController

  plug(Plug.Static, at: "/", from: :pluggy)
  plug(:put_secret_key_base)

  plug(Plug.Session,
    store: :cookie,
    key: "_pluggy_session",
    encryption_salt: "cookie store encryption salt",
    signing_salt: "cookie store signing salt",
    key_length: 64,
    log: :debug,
    secret_key_base: "-- LONG STRING WITH AT LEAST 64 BYTES --"
  )

  plug(:fetch_session)
  plug(Plug.Parsers, parsers: [:urlencoded, :multipart])
  plug(:match)
  plug(:dispatch)

  get("/", do: PageLoader.index(conn))
  get("/error", do: PageLoader.error(conn))
  get("/admin/new", do: AdminController.nt(conn))
  get("/teacher/home", do: TeacherController.home(conn))
  get("/teacher/play", do: TeacherController.play(conn))

  post("/newT", do: AdminController.newT(conn, conn.body_params))
  post("/login", do: UserController.login(conn, conn.body_params))
  post("/logout", do: UserController.logout(conn))

  match _ do
    send_resp(conn, 404, "oops")
  end

  defp put_secret_key_base(conn, _) do
    put_in(
      conn.secret_key_base,
      "-- LONG STRING WITH AT LEAST 64 BYTES LONG STRING WITH AT LEAST 64 BYTES --"
    )
  end
end
