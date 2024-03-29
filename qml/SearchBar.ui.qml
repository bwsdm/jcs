import QtLocation
import QtPositioning
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.VirtualKeyboard
import QtQuick.Window

Item {
  id: sbContainer

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

  GridLayout {
    id: sbGridLayout

    columns: 2
    columnSpacing: 10
    anchors.fill: parent

    TextField {
      id: sbTextField
      font.pointSize: 20
      Layout.preferredWidth: 656
      Component.onCompleted: {
        console.log("Width: " + width)
      }
    }

    Button {
      id: sbSearchButton
      objectName: "sbSearchButton"
      text: "Search"
      font.pointSize: 20
      Layout.alignment: Qt.AlignRight
      onClicked: {
        console.log("clickInitiator check: " + clickInitiator)

        if (clickInitiator == "swSongSearchButton") {
          window.songButtonClicked(sbTextField.text)
          sbSearchLoader.source = "Results.qml"
        } else {
          window.playlistButtonClicked(sbTextField.text)
          sbSearchLoader.source = "Results.qml"
        }
      }
    }
    Loader {
      id: sbSearchLoader
      onStatusChanged: {
      }
    }
  }


}
