<template>
  <v-container>
    <v-form
      ref="form"
      v-model="valid"
      lazy-validation
      @submit.prevent="submitForm"
    >
      <v-card
        ><v-toolbar flat color="white success--text ">
          <v-icon color="success">mdi-account-plus</v-icon>
          <v-toolbar-title class="font-weight-light">
            Create Patient
          </v-toolbar-title>
        </v-toolbar>
        <v-card-text>
          <v-container>
            <v-row>
              <v-col cols="12">
                <v-text-field
                  v-model="patient.AMKA"
                  :rules="AMKARules"
                  color="success"
                  text-color="black"
                  label="AMKA"
                ></v-text-field>
              </v-col>
            </v-row>
            <v-row>
              <v-col cols="12" sm="6">
                <v-text-field
                  v-model="patient.name"
                  :rules="nameRules"
                  label="Name"
                  color="success"
                  text-color="black"
                ></v-text-field>
              </v-col>
              <v-col cols="12" sm="6">
                <v-text-field
                  v-model="patient.surname"
                  :rules="surNameRules"
                  label="Surname"
                  color="success"
                  text-color="black"
                ></v-text-field>
              </v-col>
            </v-row>

            <v-row>
              <v-col cols="12" sm="6">
                <v-text-field
                  v-model="patient.age"
                  label="Age"
                  color="success"
                  :rules="[(v) => !!v || 'Age is required']"
                  text-color="black"
                  type="number"
                ></v-text-field>
              </v-col>
              <v-col cols="12" sm="6">
                <v-checkbox
                  v-model="patient.hospitalized"
                  label="Hospitalized"
                  color="success"
                ></v-checkbox>
              </v-col>
            </v-row>
            <v-row>
              <v-col cols="12">
                <v-select
                  v-model="patient.sex"
                  :items="sex"
                  :rules="[(v) => !!v || 'Sex is required']"
                  label="Sex"
                ></v-select>
              </v-col>
              <v-col cols="12">
                <v-select
                  v-model="patient.conditions"
                  :items="conditions"
                  :rules="[(v) => !!v || 'Item is required']"
                  label="Conditions"
                  multiple
                  required
                ></v-select>
              </v-col>
            </v-row>
          </v-container>
        </v-card-text>
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn color="success" type="submit"> Create </v-btn>
        </v-card-actions>
      </v-card>
    </v-form>
    <v-snackbar v-model="snackbar">
      {{ response }}

      <template v-slot:action="{ attrs }">
        <v-btn color="pink" text v-bind="attrs" @click="snackbar = false">
          Close
        </v-btn>
      </template>
    </v-snackbar>
  </v-container>
</template>
<script>
import axios from "axios";

export default {
  name: "PatientCreate",
  data() {
    return {
      patient: {},
      response: null,
      snackbar: false,
      valid: true,
      conditions: ["ill", "cancer"],
      sex: ["Male", "Female"],
      AMKARules: [
        (v) => !!v || "AMKA is required",
        (v) => /^\d+$/.test(v) || "AMKA must have only numbers",
        (v) => (v && v.length == 11) || "AMKA must have 11 numbers",
      ],
      nameRules: [
        (v) => !!v || "Name is required",
        (v) => /[a-zA-Z]+$/.test(v) || "Name must only contain letters",
      ],
      surNameRules: [
        (v) => !!v || "Surname is required",
        (v) => /[a-zA-Z]+$/.test(v) || "Name must only contain letters",
      ],
    };
  },
  methods: {
    submitForm() {
      if (!this.$refs.form.validate()) return false;
      axios
        .post("http://localhost:3000/patients", this.patient)
        .then((response) =>
          this.$router.push({
            name: "View patients",
            params: { message: response.data },
          })
        );

      //
    },
  },
};
</script>
