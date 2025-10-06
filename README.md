# PhavoritesElixir

Ran these generations:
`mix phx.gen.json Accounts User users username:string email:string password:string profile_picture:string`
`mix phx.gen.json Music Song songs song_name:string data:string venue_name:string venue_location:string vote_count:integer voted_by:references:users user_who_posted:references:users description:string slug:string`

To start your Phoenix server:

* Run `mix setup` to install and setup dependencies
* Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

* Official website: https://www.phoenixframework.org/
* Guides: https://hexdocs.pm/phoenix/overview.html
* Docs: https://hexdocs.pm/phoenix
* Forum: https://elixirforum.com/c/phoenix-forum
* Source: https://github.com/phoenixframework/phoenix
