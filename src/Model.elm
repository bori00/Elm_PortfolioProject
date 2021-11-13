module Model exposing (..)

import Html exposing (b, div, p, text)
import Model.Date as Date
import Model.Event as Event exposing (Event)
import Model.Event.Category exposing (EventCategory(..), SelectedEventCategories, allSelected)
import Model.Interval as Interval
import Model.PersonalDetails exposing (DetailWithName, PersonalDetails)
import Model.Repo exposing (Repo)


type alias Model =
    { personalDetails : PersonalDetails
    , events : List Event
    , selectedEventCategories : SelectedEventCategories
    , repos : List Repo
    }


academicEvents : List Event
academicEvents =
    [ { title = "Started Studying at the Technical University of Cluj-Napoca"
      , interval = Interval.open (Date.full 2019 Date.Oct)
      , description = p [] [ text "GPA: 9.90" ]
      , category = Academic
      , url = Just "https://www.utcluj.ro/"
      , tags = []
      , important = True
      }
    , { title = "Studied at the Báthory István High School"
      , interval = Interval.withDurationYears (Date.onlyYear 2007) 12
      , description = div [] [ text "Main subjects: mathematics, informatics"]
      , category = Academic
      , url = Nothing
      , tags = []
      , important = False
      }
    ]


workEvents : List Event
workEvents =
    [ { title = "STEP intern at Google"
      , interval = Interval.withDurationMonths 2020 Date.Jul 3
      , description = text "Internship, with a focus on web development"
      , category = Work
      , url = Nothing
      , tags = ["Full-Stack", "Java", "JavaScript", "Google AppEngine", "Maps API"]
      , important = False
      }
    , { title = "SRE intern at Google"
      , interval = Interval.withDurationMonths 2021 Date.Jun 3
      , description = text "Internship, with a focus in big data and data analysis"
      , category = Work
      , url = Nothing
      , tags = ["MapReduce", "Flume", "C++", "Python"]
      , important = True
      }
    ]


projectEvens : List Event
projectEvens =
    [ { title = "Robert Bosch scholarship recipient"
      , interval = Interval.open (Date.full 2021 Date.Nov)
      , description = text "Working on a project related to big data and data science"
      , category = Project
      , url = Just "https://www.bosch.ro/compania-noastra/bosch-in-romania/centrul-de-inginerie-bosch/"
      , tags = []
      , important = False
      }
    ]


personalDetails : PersonalDetails
personalDetails =
    { name = "Borbála Fazakas"
    , intro = "I want to make the world a better place through intelligent software"
    , contacts = [ DetailWithName "email" "bori@utcn.com",
                   DetailWithName "phone" "0741123456" ]
    , socials = [ DetailWithName "github" "https://github.com/bori00",
                  DetailWithName "LinkedIn" "https://www.linkedin.com/in/borbalafazakas318695189/"]
    }


initModel : Model
initModel =
    { personalDetails = personalDetails
    , events = Event.sortByInterval <| academicEvents ++ workEvents ++ projectEvens
    , selectedEventCategories = allSelected
    , repos = []
    }
