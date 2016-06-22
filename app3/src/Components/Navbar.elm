module Components.Navbar exposing (..)

import Html exposing (..)
import Html.App as Html
import Html.Events exposing (..)
import Html.Attributes exposing (..)

{-
<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
      <ul class="nav navbar-nav">
        <li class="active"><a href="#">Link <span class="sr-only">(current)</span></a></li>
        <li><a href="#">Link</a></li>
        <li class="dropdown">
          <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Dropdown <span class="caret"></span></a>
          <ul class="dropdown-menu">
            <li><a href="#">Action</a></li>
            <li><a href="#">Another action</a></li>
            <li><a href="#">Something else here</a></li>
            <li role="separator" class="divider"></li>
            <li><a href="#">Separated link</a></li>
            <li role="separator" class="divider"></li>
            <li><a href="#">One more separated link</a></li>
          </ul>
        </li>
      </ul>
      <form class="navbar-form navbar-left" role="search">
        <div class="form-group">
          <input type="text" class="form-control" placeholder="Search">
        </div>
        <button type="submit" class="btn btn-default">Submit</button>
      </form>
      <ul class="nav navbar-nav navbar-right">
        <li><a href="#">Link</a></li>
        <li class="dropdown">
          <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Dropdown <span class="caret"></span></a>
          <ul class="dropdown-menu">
            <li><a href="#">Action</a></li>
            <li><a href="#">Another action</a></li>
            <li><a href="#">Something else here</a></li>
            <li role="separator" class="divider"></li>
            <li><a href="#">Separated link</a></li>
          </ul>
        </li>
      </ul>
    </div><!-- /.navbar-collapse -->
-}

type alias NavbarData = {
  site_name : String
}

navbar : NavbarData -> Html msg
navbar data =
  div [class "navbar navbar-default"]
    [ div [class "container-fluid"]
      [ navbarHeader data
      , navbarCollapse data
      ]
    ]

navbarHeader : NavbarData -> Html msg
navbarHeader data =
  div [class "navbar-header"]
    [ button
      [ type' "button"
      , class "navbar-toggle collapsed"
      , attribute "data-toggle" "collapse"
      , attribute "data-target" "bs-example-navbar-collapse-1"
      , attribute "aria-expanded" "false"
      ]
      [ span [class "sr-only"] [text "Toggle navigation"]
      , span [class "icon-bar"] []
      , span [class "icon-bar"] []
      , span [class "icon-bar"] []
      ]
    , a [class "navbar-brand"] [ text data.site_name ]
    ]

navbarCollapse : NavbarData -> Html msg
navbarCollapse data =
  div [class "collapse navbar-collapse", id "bs-example-navbar-collapse-1"]
    [ ul [class "nav navbar-nav"]
      [ li [class "active"] [ a [href "#"] [text "Link", span [class "sr-only"] [text "(current)"]] ]
      , li [] [ a [href "#"] [text "Link"] ]
      ]
    ]
