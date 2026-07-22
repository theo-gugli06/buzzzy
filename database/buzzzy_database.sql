CREATE DATABASE buzzzy_db;

CREATE TABLE "user" (
    id SERIAL PRIMARY KEY,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    firstname VARCHAR(100) NOT NULL,
    lastname VARCHAR(100) NOT NULL,
    phone VARCHAR(30),
    "isActive" BOOLEAN NOT NULL DEFAULT TRUE,
    "createdAt" TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP
);

CREATE TABLE status (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE,
    label VARCHAR(100) NOT NULL
);

INSERT INTO status (name, label) VALUES
('pending', 'pending'),
('confirmed', 'confirmed'),
('cancelled', 'cancelled'),
('completed', 'completed');

CREATE TABLE role (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE,
    label VARCHAR(100) NOT NULL
);

INSERT INTO role (name, label) VALUES
('owner', 'Propriétaire'),
('manager', 'Gérant'),
('employee', 'Employé');

CREATE TABLE salon (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description VARCHAR(1000),
        category VARCHAR(100) NOT NULL,
        specialty VARCHAR(100) NOT NULL,
    phone VARCHAR(30) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    address VARCHAR(255) NOT NULL,
    city VARCHAR(100) NOT NULL,
    "postalCode" VARCHAR(20) NOT NULL,
    country VARCHAR(100) NOT NULL,
        latitude DECIMAL(10, 7), 
        longitude DECIMAL(10, 7),
    "isActive" BOOLEAN NOT NULL DEFAULT TRUE,
    "createdAt" TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP
);

CREATE TABLE "salonMember" (
    id SERIAL PRIMARY KEY,
    "userId" INTEGER NOT NULL,
    "salonId" INTEGER NOT NULL,
    "roleId" INTEGER NOT NULL,
    "isActive" BOOLEAN NOT NULL DEFAULT TRUE,
    "createdAt" TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP,

    CONSTRAINT "fk_salonMember_user"
        FOREIGN KEY ("userId") REFERENCES "user"(id),

    CONSTRAINT "fk_salonMember_salon"
        FOREIGN KEY ("salonId") REFERENCES salon(id),

    CONSTRAINT "fk_salonMember_role"
        FOREIGN KEY ("roleId") REFERENCES role(id)
);

CREATE TABLE service (
    id SERIAL PRIMARY KEY,
    "salonId" INTEGER NOT NULL,
    name VARCHAR(255) NOT NULL,
    description VARCHAR(1000),
    duration INTEGER NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    "isActive" BOOLEAN NOT NULL DEFAULT TRUE,
    "createdAt" TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP,

    CONSTRAINT "fk_service_salon"
        FOREIGN KEY ("salonId") REFERENCES salon(id)
);

CREATE TABLE appointment (
    id SERIAL PRIMARY KEY,
    "clientId" INTEGER NOT NULL,
    "salonId" INTEGER NOT NULL,
    "serviceId" INTEGER NOT NULL,
    "salonMemberId" INTEGER NOT NULL,
    "startAt" TIMESTAMP NOT NULL,
    "endAt" TIMESTAMP NOT NULL,
    "statusId" INTEGER NOT NULL,
    "createdAt" TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP,

    CONSTRAINT "fk_appointment_client"
        FOREIGN KEY ("clientId") REFERENCES "user"(id),

    CONSTRAINT "fk_appointment_salon"
        FOREIGN KEY ("salonId") REFERENCES salon(id),

    CONSTRAINT "fk_appointment_service"
        FOREIGN KEY ("serviceId") REFERENCES service(id),

    CONSTRAINT "fk_appointment_salonMember"
        FOREIGN KEY ("salonMemberId") REFERENCES "salonMember"(id),

    CONSTRAINT "fk_appointment_status"
        FOREIGN KEY ("statusId") REFERENCES status(id)
);

CREATE TABLE review (
    id SERIAL PRIMARY KEY,
    "appointmentId" INTEGER NOT NULL UNIQUE,
    rating INTEGER NOT NULL CHECK (rating BETWEEN 1 AND 5),
    comment VARCHAR(1000),
    "createdAt" TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP,

    CONSTRAINT "fk_review_appointment"
        FOREIGN KEY ("appointmentId") REFERENCES appointment(id)
);

CREATE TABLE "staffAvailability" (
    id SERIAL PRIMARY KEY,
    "salonMemberId" INTEGER NOT NULL,
    "dayOfWeek" INTEGER NOT NULL CHECK ("dayOfWeek" BETWEEN 1 AND 7),
    "startTime" TIME NOT NULL,
    "endTime" TIME NOT NULL,
    "createdAt" TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP,

    CONSTRAINT "fk_staffAvailability_salonMember"
        FOREIGN KEY ("salonMemberId") REFERENCES "salonMember"(id)
);

CREATE TABLE "staffTimeOff" (
    id SERIAL PRIMARY KEY,
    "salonMemberId" INTEGER NOT NULL,
    "startAt" TIMESTAMP NOT NULL,
    "endAt" TIMESTAMP NOT NULL,
    reason VARCHAR(1000),
    "createdAt" TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP,

    CONSTRAINT "fk_staffTimeOff_salonMember"
        FOREIGN KEY ("salonMemberId") REFERENCES "salonMember"(id)
);

CREATE TABLE "salonTimeOff" (
    id SERIAL PRIMARY KEY,
    "salonId" INTEGER NOT NULL,
    "startAt" TIMESTAMP NOT NULL,
    "endAt" TIMESTAMP NOT NULL,
    reason VARCHAR(1000),
    "createdAt" TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP,

    CONSTRAINT "fk_salonTimeOff_salon"
        FOREIGN KEY ("salonId") REFERENCES salon(id)
);

CREATE TABLE "openingHours" (
    id SERIAL PRIMARY KEY,
    "salonId" INTEGER NOT NULL,
    "dayOfWeek" INTEGER NOT NULL CHECK ("dayOfWeek" BETWEEN 1 AND 7),
    "openTime" TIME,
    "closeTime" TIME,
    "isClosed" BOOLEAN NOT NULL DEFAULT FALSE,
    "createdAt" TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP,

    CONSTRAINT "fk_openingHours_salon"
        FOREIGN KEY ("salonId") REFERENCES salon(id)
);

CREATE TABLE "salonPhoto" (
    id SERIAL PRIMARY KEY,
    "salonId" INTEGER NOT NULL,
    "imageUrl" VARCHAR(500) NOT NULL,
    "isCover" BOOLEAN NOT NULL DEFAULT FALSE,
    position INTEGER NOT NULL DEFAULT 0,
    "createdAt" TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP,

    CONSTRAINT "fk_salonPhoto_salon"
        FOREIGN KEY ("salonId") REFERENCES salon(id)
);