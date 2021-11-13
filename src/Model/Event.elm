module Model.Event exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, classList, href)
import Model.Event.Category exposing (EventCategory(..))
import Model.Interval as Interval exposing (Interval)


type alias Event =
    { title : String
    , interval : Interval
    , description : Html Never
    , category : EventCategory
    , url : Maybe String
    , tags : List String
    , important : Bool
    }


categoryView : EventCategory -> Html Never
categoryView category =
    case category of
        Academic ->
            text "Academic"

        Work ->
            text "Work"

        Project ->
            text "Project"

        Award ->
            text "Award"


sortByInterval : List Event -> List Event
sortByInterval events =
    List.sortWith (\evt1 evt2 -> Interval.compare evt1.interval evt2.interval) events

view : Event -> Html Never
view event =
    let
        event_url_view = case event.url of
                            Just url -> a [href url] [text "click here"]
                            Nothing -> text "Missing"
    in
    div [classList [("event", True), ("event-important", event.important)]] [
        h3 [class "event-title"] [text event.title],
        h5 [class "event-interval"] [Interval.view event.interval],
        p [class "event-description"] [event.description],
        p [class "event-category"] [categoryView event.category],
        p [class "event-url"] [
            text "Link to the event: ",
            event_url_view
        ],
        ul [class "event-tags-list"] <| List.map
             (\tag -> li [class "event-tag"][
                     text tag
                 ])
         event.tags
    ]

