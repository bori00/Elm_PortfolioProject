module Model.Repo exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, href)
import Json.Decode as Dec


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
        h3 [class "repo-name"] [text repo.name],
        p [class "repo-description"] [text (repo.description |> Maybe.withDefault "")],
        div [class "repo-url"] [
            a [href repo.url] [text "link"]
        ],
        p [class "repo-stars"] [
            text ("stars: " ++ String.fromInt(repo.stars))
        ]
    ]

{-| Based on the context, I assumed that sortByStars needs to sort in descending order.
-}
sortByStars : List Repo -> List Repo
sortByStars repos =
    List.sortWith (\repo1 repo2 -> (Basics.compare repo2.stars repo1.stars)) repos


{-| Deserializes a JSON object to a `Repo`.
Field mapping (JSON -> Elm):

  - name -> name
  - description -> description
  - html\_url -> url
  - pushed\_at -> pushedAt
  - stargazers\_count -> stars

-}
decodeRepo : Dec.Decoder Repo
decodeRepo =
    Dec.map5 Repo
        (Dec.field "name" Dec.string)
        (Dec.maybe (Dec.field "description" Dec.string))
        (Dec.field "html_url" Dec.string)
        (Dec.field "pushed_at" Dec.string)
        (Dec.field "stargazers_count" Dec.int)
