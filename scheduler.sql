
-- DDL for course-scheduler
-- Project for Databases, Professor David Chiu
-- Author : Lia Chin-Purcell, Sarah McClain, Sarah Walling-Bell
-- Date: 11/7/19

PRAGMA foreign_keys = ON;

drop table if exists Courses;
drop table if exists CourseScheduled;
drop table if exists Teaches;
drop table if exists Professors;
drop table if exists PreferredTimes;
drop table if exists PreferredDays;
drop table if exists Overlap;
drop table if exists PreferredCourses;



CREATE TABLE Courses (
  subjectID TEXT NOT NULL,
  courseID INTEGER NOT NULL,
  courseName TEXT NOT NULL,
  daysPerWeek INTEGER check(daysPerWeek <= 5 AND daysPerWeek > 0),
  numSections INTEGER,
  hoursPerWeek INTEGER,
  teachingUnits REAL,

  PRIMARY KEY(subjectID, courseID)
);

CREATE TABLE Professors (
  profID INTEGER PRIMARY KEY,
  profName TEXT,
  numPreps INTEGER,
  numCourses REAL,
  canVote TEXT CHECK(canVote LIKE 'y' OR canVote LIKE 'n'),
  tenure TEXT CHECK(tenure LIKE 'y' OR tenure LIKE 'n')
);

CREATE TABLE CourseScheduled (
    courseSchedID INTEGER PRIMARY KEY,
    subjectID INTEGER,
    courseID INTEGER,
    section TEXT,
    meetDays TEXT,
    meetTimes TEXT,
    endTimes TEXT,
    profID INTEGER,

    FOREIGN KEY (subjectID, courseID) REFERENCES Courses(subjectID, courseID),
    FOREIGN KEY (profID) REFERENCES Professors(profID)
);

CREATE TABLE Teaches (
    profID INTEGER NOT NULL,
    subjectID INTEGER NOT NULL,
    courseID INTEGER NOT NULL,

    PRIMARY KEY(profID, subjectID, courseID),

    FOREIGN KEY (subjectID, courseID) REFERENCES Courses(subjectID, courseID),
    FOREIGN KEY (profID) REFERENCES Professors(profID)
);

CREATE TABLE PreferredDays (
    profID INTEGER NOT NULL,
    preferredDay TEXT NOT NULL,

    PRIMARY KEY(profID, preferredDay),
    FOREIGN KEY (profID) REFERENCES Professors(profID)
);

CREATE TABLE PreferredTimes (
    profID INTEGER NOT NULL,
    preferredTime TEXT NOT NULL,

    PRIMARY KEY(profID, preferredTime),
    FOREIGN KEY (profID) REFERENCES Professors(profID)
);

CREATE TABLE Overlap (
  subjectIDA TEXT,
  courseIDA INTEGER,
  subjectIDB TEXT,
  courseIDB INTEGER,

  PRIMARY KEY(subjectIDA, courseIDA, subjectIDB, courseIDB),

  FOREIGN KEY (subjectIDA, courseIDA) REFERENCES Courses(subjectID, courseID),
  FOREIGN KEY (subjectIDB, courseIDB) REFERENCES Courses(subjectID, courseID)

);

CREATE TABLE PreferredCourses (
  profID INTEGER NOT NULL,
  subjectID TEXT,
  courseID TEXT,

  PRIMARY KEY(profID, subjectID, courseID),
  FOREIGN KEY (subjectID, courseID) REFERENCES Courses(subjectID, courseID),
  FOREIGN KEY (profID) REFERENCES Professors(profID)
);
