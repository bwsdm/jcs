import QtLocation
import QtPositioning
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.VirtualKeyboard
import QtQuick.Window

Item {
  id: swRoot

  function listProperties(item) {
      var properties = "";
      for (var p in item) if (typeof item[p] != "function") {
          properties += (p + ": " + item[p] + "\n");
      }
      return properties;
  }

  function listFunctions(item) {
      var functions = "";
      for (var f in item) if (typeof item[f] == "function") {
          functions += (f + ": " + item[f] + "\n");
      }
      return functions;
  }

  property bool isPlaying: false


  Rectangle {
    id: spotifyWindow

    height: 600
    width: 800
    color: "#1DB954"

    Label {
      id: swTitle
      color: "#fff"
      text: "Spotify"
      font.bold: true
      font.pointSize: 16
      anchors.top: parent.top
      anchors.horizontalCenter: parent.horizontalCenter
    }

    Item {
      id: swContainer

      height: parent.height
      width: parent.width
      anchors.rightMargin: 20
      anchors.leftMargin: 20
      anchors.bottomMargin: 20
      anchors.topMargin: 20
      anchors.bottom: parent.bottom
      anchors.left: parent.left
      anchors.right: parent.right
      anchors.top: swTitle.bottom

      GridLayout{
        id: swGridLayout

        columns: 5
        rowSpacing: 10
        anchors.fill: parent
        
        GridLayout {
          id:swDisplayContainer
          Layout.columnSpan: parent.columns
          Layout.alignment: Qt.AlignTop
          Layout.fillWidth: true

          columns: 3


          Button {
            id: swSongSearchButton
            checkable: true
            text: "Search Songs"
            font.pointSize: 20
            Layout.fillWidth: true
            onToggled: {
              if (checked) {
                swSearchLoader.clickInitiator = "swSongSearchButton"
                swSearchLoader.source = "Search.qml"
              } else {
                swSearchLoader.source = ""
              }
            }
          }

          Button {
            id: swPlaylistSearchButton
            checkable: true
            text: "Search Playlists"
            font.pointSize: 20
            Layout.fillWidth: true
            onToggled: {
              if (checked) {
                swSearchLoader.clickInitiator = "swPlaylistSearchButton"
                swSearchLoader.source = "Search.qml"
              } else {
                swSearchLoader.source = ""
              }
            }
          }

          Button {
            id: swSelfPlaylistButton
            checkable: true
            text: "Self Playlists"
            font.pointSize: 20
            Layout.fillWidth: true
            onToggled: {
              if (checked) {
                swSearchLoader.clickInitiator = "swSelfPlaylistButton"
                swSearchLoader.source = "Results.qml"
                window.selfButtonClicked()
              } else {
                swSearchLoader.source = ""
              }
            }
          }


          Loader {
            id: swSearchLoader
            property string clickInitiator
            onStatusChanged: {
              console.log(status)
              console.log(item)
            }
          }
        }


        RowLayout {
          id: swPlayerContainer
          Layout.columnSpan: parent.columns
          Layout.alignment: Qt.AlignBottom
          

          Button {
            id: swPlayerPrev
            icon.source: "../images/round-fast-rewind.svg"
            icon.width: 35
            icon.height: 35
            font.pointSize: 20
            height: 50
            onClicked: {
              console.log("Player Prev Button Clicked")
              window.playerPrevButtonClicked()

            }
          }

          Button {
            id: swPlayerPlay
            checkable: true
            icon.source: "../images/round-play-arrow.svg"
            icon.height: 35
            icon.width: 35
            font.pointSize: 20
            onToggled: {
              if (swRoot.isPlaying) {
                window.playerPauseButtonClicked()
                icon.source = "../images/round-play-arrow.svg"
                swRoot.isPlaying = false
              } else {
                window.playerPlayButtonClicked()
                icon.source = "../images/round-pause.svg"
                swRoot.isPlaying = true
              }
            }
            

          }

          ProgressBar {
            value: 0.5
            Layout.fillWidth: true
          }

          Button {
            id: swPlayerNext
            icon.source: "../images/round-fast-forward.svg"
            icon.height: 35
            icon.width: 35
            font.pointSize: 20
            onClicked: {
              console.log("Player Forward Button Clicked")
              window.playerNextButtonClicked()
            }
          }
        }
      }
    }
  }
}
