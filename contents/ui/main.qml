import QtQuick 6.5
import QtQuick.Controls 6.5
import QtQuick.Layouts 6.5
import org.kde.kirigami 2.20 as Kirigami
import org.kde.ksysguard.sensors 1.0 as Sensors
import org.kde.plasma.core as PlasmaCore
import org.kde.plasma.plasmoid 2.0

PlasmoidItem {
    id: root

    // Will make this more configurable later
    readonly property int fixedWidth: 150

    width: fixedWidth
    Layout.minimumWidth: fixedWidth
    Layout.maximumWidth: fixedWidth
    implicitHeight: Kirigami.Units.gridUnit

    Plasmoid.backgroundHints: PlasmaCore.Types.NoBackground

    // Might add swap, upload and download
    Sensors.Sensor {
        id: cpu
        sensorId: "cpu/all/usage"
    }

    Sensors.Sensor {
        id: ramUsed
        sensorId: "memory/physical/used"
    }

    Sensors.Sensor {
        id: ramTotal
        sensorId: "memory/physical/total"
    }

    property int cpuPercent: cpu.value !== undefined ? Math.round(cpu.value) : 0
    property int ramPercent: ramUsed.value !== undefined && ramTotal.value !== undefined && ramTotal.value > 0 ? Math.round((ramUsed.value / ramTotal.value) * 100) : 0

    Label {
        anchors.centerIn: parent

        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter

        // Will add a proper config system sometime
        font.bold: true
        font.pointSize: 10
        font.family: "Adwaita Mono, monospace"

        // Follows accent color
        // This can be hardcoded as - color: #FFFFFF
        color: Kirigami.Theme.highlightColor

        text: `CPU ${cpuPercent}% | RAM ${ramPercent}%`
    }
}
