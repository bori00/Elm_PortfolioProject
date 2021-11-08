module Model.Event.Category exposing (EventCategory(..), SelectedEventCategories, allSelected, eventCategories, isEventCategorySelected, set, view)

import Html exposing (Html, div, input, text, ul)
import Html.Attributes exposing (checked, class, style, type_)
import Html.Events exposing (onCheck)
import List exposing (..)


type EventCategory
    = Academic
    | Work
    | Project
    | Award


eventCategories =
    [ Academic, Work, Project, Award ]


{-| Type used to represent the state of the selected event categories.

    Although in the background the type is represented by a list, the implementation guarantees
    that the list is in fact a set: each element occurs exactly once. Given that the list is
    expected to have length <= 4, this approach does not represent a performance issue, but
    allows for later extensions (for example, defining a new eventCategory or deleting one of the
    categories would not require changes in the implementationn of SelectedEventCategories).
-}
type SelectedEventCategories
    = SelectedEventCategories (List EventCategory)


{-| Returns an instance of `SelectedEventCategories` with all categories selected

    isEventCategorySelected Academic allSelected --> True

-}
allSelected : SelectedEventCategories
allSelected =
    SelectedEventCategories [Academic, Work, Project, Award]


{-| Given a the current state and a `category` it returns whether the `category` is selected.

    isEventCategorySelected Academic allSelected --> True

-}
isEventCategorySelected : EventCategory -> SelectedEventCategories -> Bool
isEventCategorySelected category current =
    let
        (SelectedEventCategories selectedList) = current
    in
        selectedList |> List.member category


{-| Given an `category`, a boolean `value` and the current state, it sets the given `category` in `current` to `value`.

    allSelected |> set Academic False |> isEventCategorySelected Academic --> False

    allSelected |> set Academic False |> isEventCategorySelected Work --> True

-}
set : EventCategory -> Bool -> SelectedEventCategories -> SelectedEventCategories
set category value current =
    let
        (SelectedEventCategories selectedList) = current
    in
        if value && not (List.member category selectedList) then
            SelectedEventCategories (category :: selectedList)
        else if not value then
            selectedList |> List.filter (\c -> c /= category)
                         |> SelectedEventCategories
        else current


checkbox : String -> Bool -> EventCategory -> Html ( EventCategory, Bool )
checkbox name state category =
    div [ style "display" "inline", class "category-checkbox" ]
        [ input [ type_ "checkbox", onCheck (\c -> ( category, c )), checked state ] []
        , text name
        ]


view : SelectedEventCategories -> Html ( EventCategory, Bool )
view model =
    let
        (SelectedEventCategories selectedList) = model
    in
    div [] [
        ul [] <| ([Academic, Work, Project, Award]
                    |> List.map (\eventCat -> checkbox (eventCategoryToString eventCat)
                                            (List.member eventCat selectedList)
                                            eventCat))
    ]

eventCategoryToString: EventCategory -> String
eventCategoryToString eventCat =
    case eventCat of
        Academic -> "Academic"
        Work -> "Work"
        Project -> "Project"
        Award -> "Award"