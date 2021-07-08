// Copyright (c) 2018 Ultimaker B.V.
// Cura is released under the terms of the LGPLv3 or higher.

import QtQuick 2.7
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.3

import UM 1.3 as UM
import Cura 1.1 as Cura


Item
{
    id: prepareMenu

    UM.I18nCatalog
    {
        id: catalog
        name: "cura"
    }

    anchors
    {
        left: parent.left
        right: parent.right
        leftMargin: UM.Theme.getSize("wide_margin").width * 2
        rightMargin: UM.Theme.getSize("wide_margin").width * 2
    }

    // Item to ensure that all of the buttons are nicely centered.
    Item
    {
        anchors.fill: parent

        RowLayout
        {
            id: itemRow

            anchors.left: openFileButton.right
            anchors.right: parent.right
            anchors.leftMargin: UM.Theme.getSize("default_margin").width
            property int machineSelectorWidth: Math.round((width - printSetupSelectorItem.width) / 3)

            height: parent.height
            // This is a trick to make sure that the borders of the two adjacent buttons' borders overlap. Otherwise
            // there will be double border (one from each button)
            spacing: -UM.Theme.getSize("default_lining").width

            Cura.MachineSelector
            {
                id: machineSelection
                headerCornerSide: Cura.RoundedRectangle.Direction.Left
                Layout.preferredWidth: parent.machineSelectorWidth
                Layout.fillWidth: true
                Layout.fillHeight: true
            }

            Cura.ConfigurationMenu
            {
                id: printerSetup
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.preferredWidth: parent.machineSelectorWidth * 2
            }

            Item
            {
                id: printSetupSelectorItem
                // This is a work around to prevent the printSetupSelector from having to be re-loaded every time
                // a stage switch is done.
                children: [printSetupSelector]
                height: childrenRect.height
                width: childrenRect.width
            }
        }

        Button
        {
            id: openFileButton

            //Make the button square if the contents are.
            leftPadding: topPadding
            rightPadding: topPadding
            bottomPadding: topPadding

            height: UM.Theme.getSize("stage_menu").height
            width: leftPadding + openFileIconContainer.width + openFileChevronContainer.width + rightPadding
            onClicked: Cura.Actions.open.trigger()
            hoverEnabled: true

            contentItem: Row
            {
                Item
                {
                    id: openFileIconContainer
                    height: parent.height
                    width: height //Square button.

                    UM.RecolorImage
                    {
                        id: buttonIcon
                        anchors.centerIn: parent
                        source: UM.Theme.getIcon("Folder", "medium")
                        width: UM.Theme.getSize("button_icon").width
                        height: UM.Theme.getSize("button_icon").height
                        color: UM.Theme.getColor("icon")

                        sourceSize.height: height
                    }
                }
                Item
                {
                    id: openFileChevronContainer
                    height: parent.height
                    width: UM.Theme.getSize("small_button_icon").width

                    UM.RecolorImage
                    {
                        anchors.centerIn: parent
                        source: UM.Theme.getIcon("ChevronSingleDown")
                        width: UM.Theme.getSize("small_button_icon").width
                        height: UM.Theme.getSize("small_button_icon").height
                        color: UM.Theme.getColor("icon")

                        sourceSize.height: height
                    }
                }
            }

            background: Rectangle
            {
                id: background
                height: parent.height
                width: parent.width
                border.color: UM.Theme.getColor("lining")
                border.width: UM.Theme.getSize("default_lining").width

                radius: UM.Theme.getSize("default_radius").width
                color: openFileButton.hovered ? UM.Theme.getColor("action_button_hovered") : UM.Theme.getColor("action_button")
            }
        }
    }
}
