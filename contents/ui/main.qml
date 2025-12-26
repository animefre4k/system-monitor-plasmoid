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
    readonly property int fixedWidth: 130

    width: fixedWidth
    implicitHeight: Kirigami.Units.gridUnit

    Layout.minimumWidth: fixedWidth
    Layout.maximumWidth: fixedWidth

    Plasmoid.backgroundHints: PlasmaCore.Types.NoBackground

    // Sensors
    Sensors.Sensor {
        id: cpu
        sensorId: "cpu/all/usage"
        updateRateLimit: 1000
    }

    Sensors.Sensor {
        id: ramUsed
        sensorId: "memory/physical/used"
        updateRateLimit: 1000
    }

    Sensors.Sensor {
        id: ramTotal
        sensorId: "memory/physical/total"
        updateRateLimit: 1000
    }

    property int cpuPercent: cpu.value !== undefined
    ? Math.round(cpu.value)
    : 0

    property int ramPercent:
    ramUsed.value !== undefined
    && ramTotal.value !== undefined
    && ramTotal.value > 0
    ? Math.round((ramUsed.value / ramTotal.value) * 100)
    : 0

    RowLayout {
        anchors.centerIn: parent
        spacing: Kirigami.Units.smallSpacing

        Label {
            text: "CPU"
            font.bold: true
            color: Kirigami.Theme.highlightColor
        }

        Label {
            text: `${cpuPercent}%`
            color: Kirigami.Theme.highlightColor
        }

        Label {
            text: "RAM"
            font.bold: true
            Layout.leftMargin: Kirigami.Units.smallSpacing
            color: Kirigami.Theme.highlightColor
        }

        Label {
            text: `${ramPercent}%`
            color: Kirigami.Theme.highlightColor
        }
    }
}
