defmodule Pluggy.Seed do

  def run() do
    reset_admin()
    reset_teachers()
    reset_groups()
    reset_schools()
    reset_teachers_schools()
  end

  defp reset_admin() do
    Postgrex.query!(DB, "DROP TABLE IF EXISTS admin", [], pool: DBConnection.Poolboy)
    Postgrex.query!(DB, "CREATE TABLE admin(
                        id SERIAL PRIMARY KEY,
                        name VARCHAR(255) NOT NULL,
                        password VARCHAR(255) NOT NULL,
                        rights BOOLEAN)",
                        [],
                        pool: DBConnection.Poolboy)
    Postgrex.query!(DB, "INSERT INTO admin (name, password, rights)
                        VALUES('Admin', 'Password', true)",
                        [],
                        pool: DBConnection.Poolboy)
  end

  defp reset_teachers() do
    Postgrex.query!(DB, "DROP TABLE IF EXISTS teachers", [], pool: DBConnection.Poolboy)
    Postgrex.query!(DB, "CREATE TABLE teachers(
                        id SERIAL PRIMARY KEY,
                        name VARCHAR(255) NOT NULL,
                        password VARCHAR(255) NOT NULL,
                        rights BOOLEAN)",
                        [],
                        pool: DBConnection.Poolboy)

  end

  defp reset_groups() do
    Postgrex.query!(DB, "DROP TABLE IF EXISTS groups", [], pool: DBConnection.Poolboy)
    Postgrex.query!(DB, "CREATE TABLE groups(
                        id SERIAL PRIMARY KEY,
                        name VARCHAR(255) NOT NULL,
                        school INTEGER NOT NULL)",
                        [],
                        pool: DBConnection.Poolboy)
  end

  defp reset_schools() do
    Postgrex.query!(DB, "DROP TABLE IF EXISTS schools", [], pool: DBConnection.Poolboy)
    Postgrex.query!(DB, "CREATE TABLE schools(
                        id SERIAL PRIMARY KEY,
                        name VARCHAR(255) NOT NULL)",
                        [],
                        pool: DBConnection.Poolboy)
  end

  defp reset_teachers_schools() do
    Postgrex.query!(DB, "DROP TABLE IF EXISTS teachers_schools", [], pool: DBConnection.Poolboy)
    Postgrex.query!(DB, "CREATE TABLE teachers_schools(
                        teacher_id INTEGER,
                        school_id INTEGER)",
                        [],
                        pool: DBConnection.Poolboy)
  end
end




