/* -*- mode: SQL; -*-
  Note, in SQLite:
  INTEGER NOT NULL PRIMARY KEY -->     Auto Increment
  INT     NOT NULL ...         --> Not Auto Increment
*/

CREATE TABLE IF NOT EXISTS `Theme`(
    `IdTheme` INTEGER NOT NULL PRIMARY KEY /* AUTOINCREMENT Theme Id */,
    `NaTheme` VARCHAR(30) NOT NULL UNIQUE /* Theme Name */,
    `Composition` VARCHAR(40) NOT NULL /* Configuration of periods */
); /* Themes */
CREATE TABLE IF NOT EXISTS `ResourceType`(
    `IdResourceType` INTEGER NOT NULL PRIMARY KEY /* AUTOINCREMENT Resource Type Id */,
    `NaResourceType` VARCHAR(15) NOT NULL UNIQUE /* Name */,
    `NumResourceLimit` INT NOT NULL /* Default Max Number of Resources per Activity */,
    `ValResourceType` INT NOT NULL /* Value of Clashes */,
    `MaxWorkLoad` INT /* Work Load Limit of Resource */
); /* Resource types */
CREATE TABLE IF NOT EXISTS `Day`(
    `IdDay` INTEGER NOT NULL PRIMARY KEY /* AUTOINCREMENT Day Id */,
    `NaDay` VARCHAR(10) NOT NULL UNIQUE /* Name of Day */
); /* Working Days */
CREATE TABLE IF NOT EXISTS `Hour`(
    `IdHour` INTEGER NOT NULL PRIMARY KEY /* AUTOINCREMENT Hour Id */,
    `NaHour` VARCHAR(10) NOT NULL UNIQUE /* Hour Name */,
    `Interval` VARCHAR(21) NOT NULL UNIQUE /* Hour Interval */
); /* Academic Hours */
CREATE TABLE IF NOT EXISTS `Resource`(
    `IdResourceType` INT NOT NULL /* Resource Type Id */,
    `IdResource` INTEGER NOT NULL PRIMARY KEY /* AUTOINCREMENT Resource Id */,
    `NaResource` VARCHAR(25) NOT NULL UNIQUE /* Resource Name */,
    `AbResource` VARCHAR(15) NOT NULL UNIQUE /* Resource Abbreviation */,
    `NumResource` INT NOT NULL /* Number of resources */,
  CONSTRAINT `IxResourceResourceType` UNIQUE(`IdResourceType`,`IdResource`),
  CONSTRAINT `ResourceTypeResource` FOREIGN KEY (`IdResourceType`)
    REFERENCES `ResourceType`(`IdResourceType`) ON UPDATE RESTRICT ON DELETE RESTRICT
); /* Resources */
CREATE TABLE IF NOT EXISTS `Period`(
    `IdDay` INT NOT NULL /* Day Id */,
    `IdHour` INT NOT NULL /* Hour Id */,
  CONSTRAINT `PrimaryKey` PRIMARY KEY(`IdDay`,`IdHour`),
  CONSTRAINT `DayPeriod` FOREIGN KEY (`IdDay`)
    REFERENCES `Day`(`IdDay`) ON UPDATE RESTRICT ON DELETE RESTRICT,
  CONSTRAINT `HourPeriod` FOREIGN KEY (`IdHour`)
    REFERENCES `Hour`(`IdHour`) ON UPDATE RESTRICT ON DELETE RESTRICT
); /* Periods */
CREATE TABLE IF NOT EXISTS `Activity`(
    `IdActivity` INTEGER NOT NULL PRIMARY KEY /* AUTOINCREMENT Activity Id */,
    `IdTheme` INT NOT NULL /* Theme Id */,
    `NaActivity` VARCHAR(25) NOT NULL /* Activity Name */,
  CONSTRAINT `IxThemeActivity` UNIQUE(`IdTheme`,`NaActivity`),
  CONSTRAINT `ThemeActivity` FOREIGN KEY (`IdTheme`)
    REFERENCES `Theme`(`IdTheme`) ON UPDATE CASCADE ON DELETE CASCADE
); /* Activities */
CREATE TABLE IF NOT EXISTS `Availability`(
    `IdTheme` INT NOT NULL /* Theme Id */,
    `IdResource` INT NOT NULL /* Resource Id */,
    `NumResource` INT NOT NULL /* Number of Resource */,
  CONSTRAINT `PrimaryKey` PRIMARY KEY(`IdTheme`,`IdResource`),
  CONSTRAINT `ResourceAvailability` FOREIGN KEY (`IdResource`)
    REFERENCES `Resource`(`IdResource`) ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT `ThemeAvailability` FOREIGN KEY (`IdTheme`)
    REFERENCES `Theme`(`IdTheme`) ON UPDATE CASCADE ON DELETE CASCADE
); /* Availability of Resources to Cover Requirements in the Theme */
CREATE TABLE IF NOT EXISTS `ResourceTypeLimit`(
    `IdTheme` INT NOT NULL /* Theme Id */,
    `IdResourceType` INT NOT NULL /* Resource Type Id */,
    `NumResourceLimit` INT NOT NULL /* Max Number of Resource */,
  CONSTRAINT `PrimaryKey` PRIMARY KEY(`IdTheme`,`IdResourceType`),
  CONSTRAINT `ResourceTypeResourceTypeLimit` FOREIGN KEY (`IdResourceType`)
    REFERENCES `ResourceType`(`IdResourceType`) ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT `ThemeResourceTypeLimit` FOREIGN KEY (`IdTheme`)
    REFERENCES `Theme`(`IdTheme`) ON UPDATE CASCADE ON DELETE CASCADE
); /* Limits for usage of Resource Types in Themes */
CREATE TABLE IF NOT EXISTS `RestrictionType`(
    `IdRestrictionType` INTEGER NOT NULL PRIMARY KEY /* AUTOINCREMENT Restriction Type Id */,
    `NaRestrictionType` VARCHAR(10) NOT NULL UNIQUE /* Restriction Type Name */,
    `ColRestrictionType` INT NOT NULL /* Restriction Type Color */,
    `ValRestrictionType` INT NOT NULL /* Restriction Type Value */
); /* Types of Restrictions */
CREATE TABLE IF NOT EXISTS `Restriction`(
    `IdResource` INT NOT NULL /* Resource Id */,
    `IdDay` INT NOT NULL /* Day Id */,
    `IdHour` INT NOT NULL /* Hour Id */,
    `IdRestrictionType` INT NOT NULL /* Resource Restriction Type Id */,
  CONSTRAINT `PrimaryKey` PRIMARY KEY(`IdResource`,`IdDay`,`IdHour`),
  CONSTRAINT `PeriodRestriction` FOREIGN KEY (`IdDay`,`IdHour`)
    REFERENCES `Period`(`IdDay`,`IdHour`) ON UPDATE RESTRICT ON DELETE RESTRICT,
  CONSTRAINT `ResourceRestriction` FOREIGN KEY (`IdResource`)
    REFERENCES `Resource`(`IdResource`) ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT `RestrictionTypeRestriction` FOREIGN KEY (`IdRestrictionType`)
    REFERENCES `RestrictionType`(`IdRestrictionType`) ON UPDATE CASCADE ON DELETE RESTRICT
); /* Restrictions */
CREATE TABLE IF NOT EXISTS `Participant`(
    `IdActivity` INT NOT NULL /* Category Id */,
    `IdResource` INT NOT NULL /* Resource Id */,
    `NumResource` INT NOT NULL /* Number of Resources */,
  CONSTRAINT `PrimaryKey` PRIMARY KEY(`IdActivity`,`IdResource`),
  CONSTRAINT `ActivityParticipant` FOREIGN KEY (`IdActivity`)
    REFERENCES `Activity`(`IdActivity`) ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT `ResourceParticipant` FOREIGN KEY (`IdResource`)
    REFERENCES `Resource`(`IdResource`) ON UPDATE CASCADE ON DELETE RESTRICT
); /* Participants */
CREATE TABLE IF NOT EXISTS `Timetable`(
    `IdTimetable` INT NOT NULL PRIMARY KEY /* AUTOINCREMENT Timetable Id */,
    `TimeIni` DATETIME NOT NULL /* Initial Time */,
    `TimeEnd` DATETIME NOT NULL /* End Time */,
    `Summary` TEXT /* Summary of Timetable Generation */
); /* Timetables */
CREATE TABLE IF NOT EXISTS `TimetableDetail`(
    `IdTimetable` INT NOT NULL /* Timetable Id */,
    `IdActivity` INT NOT NULL /* Activity Id */,
    `IdDay` INT NOT NULL /* Day Id */,
    `IdHour` INT NOT NULL /* Hour Id */,
    `Session` INT NOT NULL /* Internal Number */,
  CONSTRAINT `PrimaryKey` PRIMARY KEY(`IdTimetable`,`IdActivity`,`IdDay`,`IdHour`),
  CONSTRAINT `ActivityTimetableDetail` FOREIGN KEY (`IdActivity`)
    REFERENCES `Activity`(`IdActivity`) ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT `PeriodTimetableDetail` FOREIGN KEY (`IdDay`,`IdHour`)
    REFERENCES `Period`(`IdDay`,`IdHour`) ON UPDATE RESTRICT ON DELETE RESTRICT,
  CONSTRAINT `TimetableTimetableDetail` FOREIGN KEY (`IdTimetable`)
    REFERENCES `Timetable`(`IdTimetable`) ON UPDATE CASCADE ON DELETE CASCADE
); /* Detail of Timetables */
CREATE TABLE IF NOT EXISTS `TimetableResource`(
    `IdTimetable` INT NOT NULL /* Timetable Id */,
    `IdActivity` INT NOT NULL /* Activity Id */,
    `IdResource` INT NOT NULL /* Resource Id */,
    `NumResource` INT NOT NULL /* Number of Resource */,
  CONSTRAINT `PrimaryKey` PRIMARY KEY(`IdTimetable`,`IdActivity`,`IdResource`),
  CONSTRAINT `ActivityTimetableResource` FOREIGN KEY (`IdActivity`)
    REFERENCES `Activity`(`IdActivity`) ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT `ResourceTimetableResource` FOREIGN KEY (`IdResource`)
    REFERENCES `Resource`(`IdResource`) ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT `TimetableTimetableResource` FOREIGN KEY (`IdTimetable`)
    REFERENCES `Timetable`(`IdTimetable`) ON UPDATE CASCADE ON DELETE CASCADE
); /* Resources of Timetables */
