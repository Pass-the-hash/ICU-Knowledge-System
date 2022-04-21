<template>
  <div>
    <v-container>
      <v-card>
        <v-toolbar flat color="white success--text ">
          <v-icon color="success">mdi-bed</v-icon>
          <v-toolbar-title class="font-weight-light">
            Ασθενείς
          </v-toolbar-title>
          <v-spacer></v-spacer>
          <v-btn color="success" href="/patients/create"
            ><v-icon color="white">mdi-account-plus</v-icon> Προσθήκη
          </v-btn>
        </v-toolbar>
        <v-tabs
          v-model="tab"
          background-color="transparent"
          color="success"
          grow
        >
          <v-tab> Νοσηλευόμενοι </v-tab>
          <v-tab> Εχουν εξελθει </v-tab>
        </v-tabs>
        <v-tabs-items v-model="tab">
          <v-tab-item>
            <v-text-field
              v-model="search"
              append-icon="mdi-magnify"
              label="Search"
              color="success"
              single-line
              hide-details
            ></v-text-field>
            <v-data-table
              :items="hospitalized_patients"
              :headers="headers"
              :items-per-page="5"
              :search="search"
            >
              <template v-slot:[`item.actions`]="{ item }">
                <v-btn
                  class="ma-2"
                  color="success"
                  @click="deletePatient(item._id.$oid)"
                >
                  <v-icon> mdi-account-convert </v-icon>
                  εξαγωγη
                </v-btn>
                <v-btn
                  class="ma-2"
                  color="success"
                  @click="updatePatientDialog(item)"
                >
                  <v-icon> mdi-account-edit </v-icon>
                  ενημερωση
                </v-btn>
                <v-btn
                    @click="$router.push({
                      path: '/analysis/' + item.AMKA,
                      // params: { patient: item }
                    })"

                class="ma-2"
                    color="success"
                >
                  <v-icon> mdi-account-injury </v-icon>
                  πληροφοριες
                </v-btn>
              </template>
            </v-data-table>
          </v-tab-item>
          <v-tab-item>
            <v-text-field
              v-model="search"
              append-icon="mdi-magnify"
              label="Search"
              color="success"
              single-line
              hide-details
            ></v-text-field>
            <v-data-table
              :items="recovered_patients"
              :headers="headers"
              :items-per-page="5"
              :search="search"
            >
              <template v-slot:[`item.actions`]="{ item }">
                <v-btn
                  class="ma-2"
                  color="success"
                  @click="updatePatientDialog(item)"
                >
                  <v-icon> mdi-account-edit </v-icon>
                  Ενημερωση
                </v-btn>
              </template>
            </v-data-table>
          </v-tab-item>
        </v-tabs-items>
      </v-card>
    </v-container>
    <v-dialog
      v-model="dialog"
      v-if="patient"
      hide-overlay
      persistent
      max-width="600px"
    >
      <v-form
        ref="form"
        v-model="valid"
        lazy-validation
        @submit.prevent="updatePatient(patient._id.$oid)"
      >
        <v-card
          ><v-card-title>
            <span class="headline"> Επεξεργασία ασθενή </span>
          </v-card-title>
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
<!--                <v-col cols="12" sm="6">
                  <v-checkbox
                    v-model="patient.hospitalized"
                    label="Hospitalized"
                    color="success"
                  ></v-checkbox>
                </v-col>-->
              </v-row>
              <v-row>
                <v-col cols="12">
                  <v-select
                    v-model="patient.gender"
                    :items="gender"
                    :rules="[(v) => !!v || 'Gender is required']"
                    label="Φύλλο"
                  ></v-select>
                </v-col>
                <v-col cols="12">
                  <v-text-field
                    v-model="patient.description"
                    :rules="[(v) => !!v || 'Item is required']"
                    label="Περιγραφή"
                    color="success"
                    multiple
                    required
                  ></v-text-field>
                </v-col>
                <v-col
                    cols="12"
                    sm="6"
                    v-if="ventilated === true"
                >

                  <v-slider
                      v-model="information.Inflammation"
                      color="success"
                      label="Μόλυνση"
                      min="1"
                      max="3"
                      thumb-label
                  ></v-slider>
                </v-col>
                <v-col
                    cols="12"
                    sm="6"
                    v-if="ventilated === true"
                >
                  <v-slider
                      v-model="information.Location"
                      color="success"
                      label="Σημείο μόλυνσης"
                      min="1"
                      max="7"
                      thumb-label
                  ></v-slider>
                  <v-slider
                      v-model="information.Organism"
                      color="success"
                      label="Τύπος μικροοργανισμού"
                      min="1"
                      max="4"
                      thumb-label
                  ></v-slider>
                </v-col>
              </v-row>
            </v-container>
          </v-card-text>
          <v-card-actions>
            <v-spacer></v-spacer>
            <v-btn color="success" text @click="dialog = false"> Κλείσιμο </v-btn>
            <v-btn color="success" text type="submit"> Ενημέρωση </v-btn>
          </v-card-actions>
        </v-card>
      </v-form>
    </v-dialog>
    <v-snackbar v-model="snackbar">
      {{ response }}

      <template v-slot:action="{ attrs }">
        <v-btn color="pink" text v-bind="attrs" @click="snackbar = false">
          Close
        </v-btn>
      </template>
    </v-snackbar>
  </div>
</template>

<script>
import axios from "axios";

export default {
  name: "Patients",
  data() {
    return {
      footer: true,
      dialog: false,
      patient: null,
      information: {},
      valid: true,
      patients: [],
      response: null,
      snackbar: false,
      search: null,
      headers: [
        {text: "AMKA", value: "AMKA" },
        { text: "Όνομα", value: "name" },
        { text: "Επώνυμο", value: "surname" },
        { text: "Ηλικία", value: "age" },
        { text: "Περιγραφή", value: "description" },
        // { text: "Hospitalized", value: "hospitalized" },
        { text: "Φύλο", value: "gender" },
        { text: "Ενέργειες", value: "actions", sortable: false },
      ],
      conditions: ["ill", "cancer"],
      gender: ["Male", "Female"],
      tab: null,
      AMKARules: [
        (v) => !!v || "AMKA is required",
        (v) => /^\d+$/.test(v) || "AMKA must have only numbers",
        (v) => (v && v.length == 11) || "AMKA must have 11 numbers",
      ],
      nameRules: [
        (v) => !!v || "Name is required",
        (v) => /[a-zA-Zα-ωΑ-Ω]+$/.test(v) || "Name must only contain letters",
      ],
      surNameRules: [
        (v) => !!v || "Surname is required",
        (v) => /[a-zA-Zα-ωΑ-Ω]+$/.test(v) || "Name must only contain letters",
      ],
    };
  },
  computed: {
    hospitalized_patients: function () {
      return this.patients.filter((pt) => pt.hospitalized === true);
    },
    recovered_patients: function () {
      return this.patients.filter((pt) => pt.hospitalized === false);
    },
  },
  mounted() {
    this.get();
    if (this.$route.params.message) {
      this.response = this.$route.params.message;
      this.snackbar = true;
    }
  },
  methods: {
      get() {
        axios
           .get("http://localhost:3000/patients")
           .then((response) => (this.patients = response.data));
     },
    updatePatientDialog(item) {
      this.patient = item;
      this.dialog = true;
    },
    deletePatient(id) {
      axios
        .delete("http://localhost:3000/patients/" + id)
        .then(() => this.$router.go(0));
    },
    updatePatient(id) {
      if (!this.$refs.form.validate()) return false;
      axios
        .patch("http://localhost:3000/patients/" + id, this.patient)
        .then(() => this.$router.go(0));
      /*axios
          .patch("http://localhost:3000/analysis/" + this.patient.AMKA, this.information)
          .then(() => this.$router.go(0));*/
    },
    async show() {
      await axios
          .get("http://localhost:3000/analysis/" + this.patient.AMKA)
          .then((response) => (this.information = response.data));
      // this.updateChart()
    }
  },
};
</script>
