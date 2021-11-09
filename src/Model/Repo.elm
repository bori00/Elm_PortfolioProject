module Model.Repo exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, href)
import Json.Decode as De


type alias Repo =
    { name : String
    , description : Maybe String
    , url : String
    , pushedAt : String
    , stars : Int
    }


view : Repo -> Html msg
view repo =
    div [class "repo"] [
        h1 [class "repo-name"] [text repo.name],
        p [class "repo-description"] [text (repo.description |> Maybe.withDefault "")],
        div [class "repo-url"] [
            a [href repo.url] [text "link"]
        ],
        p [class "repo-stars"] [
            text ("stars: " ++ String.fromInt(repo.stars))
        ]
    ]


sortByStars : List Repo -> List Repo
sortByStars repos =
    List.sortWith (\repo1 repo2 -> (Basics.compare repo1.stars repo2.stars)) repos


{-| Deserializes a JSON object to a `Repo`.
Field mapping (JSON -> Elm):

  - name -> name
  - description -> description
  - html\_url -> url
  - pushed\_at -> pushedAt
  - stargazers\_count -> stars

-}
decodeRepo : De.Decoder Repo
decodeRepo =
    De.fail "Not implemented"
    -- Debug.todo "Implement Model.Repo.decodeRepo"
