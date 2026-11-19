function Controller() {
    installer.autoRejectMessageBoxes();
    installer.installationFinished.connect(function() {
        gui.clickButton(buttons.FinishButton);
    });
}

Controller.prototype.WelcomePageCallback = function() {
    gui.clickButton(buttons.NextButton);
};

Controller.prototype.IntroductionPageCallback = function() {
    console.log("Introduction page opened");
    gui.clickButton(buttons.NextButton);
};

Controller.prototype.TargetDirectoryPageCallback = function() {
    gui.currentPageWidget().TargetDirectoryLineEdit.setText(
        installer.value("TargetDir")
    );
    gui.clickButton(buttons.NextButton);
};

Controller.prototype.ComponentSelectionPageCallback = function() {
    gui.clickButton(buttons.NextButton);
};

Controller.prototype.LicenseAgreementPageCallback = function() {
    var page = gui.currentPageWidget();
    page.AcceptLicenseRadioButton.setChecked(true);
    gui.clickButton(buttons.NextButton);
};

Controller.prototype.ReadyForInstallationPageCallback = function() {
    gui.clickButton(buttons.NextButton);
};

Controller.prototype.FinishedPageCallback = function() {
    console.log("Finished page opened");
    gui.clickButton(buttons.FinishButton);
};