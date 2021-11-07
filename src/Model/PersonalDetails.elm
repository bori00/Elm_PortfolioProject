module Model.PersonalDetails exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, classList, href, id)


type alias DetailWithName =
    { name : String
    , detail : String
    }


type alias PersonalDetails =
    { name : String
    , contacts : List DetailWithName
    , intro : String
    , socials : List DetailWithName
    }


view : PersonalDetails -> Html msg
view details =
    div [] [
        h1 [id "name"] [text details.name],
        em [id "intro"] [text details.intro],
        div [id "contactsDiv"] [
            h3 [id "contactsDivTitle"] [text "Contact"],
            ul [] <|
                List.map
                    (\contactDetailWithName -> li [class "contact-detail"]
                        [text (contactDetailWithName.name ++ ": " ++ contactDetailWithName.detail)])
                details.contacts
        ],
        div [id "socialMediaDiv"] [
            h3 [id "socialMediaDivTitle"] [text "Social Media"],
            ul [] <|
                List.map
                    (\socialLinkWithName -> li [class "social link"][
                            a [href socialLinkWithName.detail] [text socialLinkWithName.name]
                        ])
                details.socials
        ]
    ]
