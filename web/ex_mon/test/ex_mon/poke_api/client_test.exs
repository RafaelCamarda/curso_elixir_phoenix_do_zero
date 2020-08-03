defmodule ExMon.PokeApi.ClientTest do
  use ExUnit.Case
  import Tesla.Mock

  alias ExMon.PokeApi.Client

  @base_url "https://pokeapi.co/api/v2/pokemon/"

  describe "get_pokemon/1" do
    test "when there is a pokemon with the given name, returns the pokemon" do
      body = %{"name" => "pikachu", "weight" => 60, "types" => ["electric"]}

      mock(fn %{method: :get, url: @base_url <> "pikachu"} ->
        %Tesla.Env{status: 200, body: body}
      end)

      response = Client.get_pokemon("pikachu")

      expected_response = {:ok, %{"name" => "pikachu", "types" => ["electric"], "weight" => 60}}

      assert response == expected_response
    end

    test "when there no pokemon with the given name, returns the error" do
      mock(fn %{method: :get, url: @base_url <> "banana"} ->
        %Tesla.Env{status: 404}
      end)

      response = Client.get_pokemon("banana")

      expected_response = {:error, "Pokemon not found!"}

      assert response == expected_response
    end

    test "when there is an unexpected error, returns the error" do
      mock(fn %{method: :get, url: @base_url <> "pikachu"} ->
        {:error, :timeout}
      end)

      response = Client.get_pokemon("pikachu")

      expected_response = {:error, :timeout}

      assert response == expected_response
    end
  end
end
