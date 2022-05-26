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
          <v-btn color="success" to="/patients/create"
            ><v-icon color="white">mdi-account-plus</v-icon> Προσθηκη
          </v-btn>
        </v-toolbar>
        <v-tabs
          v-model="tab"
          background-color="transparent"
          color="success"
          grow
        >
          <v-tab> Νοσηλευομενοι </v-tab>
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
              :headers="hospitalizedHeaders"
              :items-per-page="5"
              :search="search"
              item-key="AMKA"
              show-expand
              class="elevation-1"
            >
              <template v-slot:expanded-item="{ headers, item }">
                <td :colspan="headers.length">
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
                </td>
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
              :headers="recoveredHeaders"
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
                <v-col cols="12">
                  <v-text-field
                    v-model="patient.age"
                    label="Age"
                    color="success"
                    :rules="[(v) => !!v || 'Age is required']"
                    text-color="black"
                    type="number"
                  ></v-text-field>
                </v-col>
              </v-row>
              <v-row>
                <v-col cols="12">
                  <v-select
                    v-model="patient.gender"
                    :items="gender"
                    :rules="[(v) => !!v || 'Gender is required']"
                    label="Φύλλο"
                    color="success"
                    item-color="success"
                    text-color="black"
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
// import VueJwtDecode from "vue-jwt-decode"

export default {
  name: "Patients",
  props: {
    message: String
  },
  data() {
    return {
      axios_headers: {
        headers:{
          'Authorization': `Basic ${localStorage.getItem('accessToken')}`
        }
      },
      dialog: false,
      patient: null,
      information: {},
      valid: true,
      patients: [],
      response: null,
      snackbar: false,
      search: null,
      hospitalizedHeaders: [
        {text: "AMKA", value: "AMKA" },
        { text: "Όνομα", value: "name" },
        { text: "Επώνυμο", value: "surname" },
        { text: "Ηλικία", value: "age" },
        { text: "Περιγραφή", value: "description" },
        // { text: "Hospitalized", value: "hospitalized" },
        { text: "Φύλο", value: "gender" },
        { text: '', value: 'data-table-expand' },
      ],
      recoveredHeaders: [
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
      gender: ["Άντρας", "Γυναίκα"],
      tab: null,
      AMKARules: [
        (v) => !!v || "AMKA is required",
        (v) => /^\d+$/.test(v) || "AMKA must have only numbers",
        (v) => (v && v.length === 11) || "AMKA must have 11 numbers",
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
    if(this.message){
      this.snackbar=true;
      this.response=this.message;
    }

  },
  methods: {
      get() {
        axios
           .get("http://localhost:3000/patients", this.axios_headers)
           .then((response) => (this.patients = response.data));
     },
    updatePatientDialog(item) {
      this.patient = item;
      this.dialog = true;
    },
    deletePatient(id) {
      axios
        .delete("http://localhost:3000/patients/" + id, this.axios_headers)
        .then((response) =>
          {
          const patient = this.patients.find((pt) => pt._id.$oid == id)
          let index = this.patients.findIndex((pt) => pt._id.$oid == id);
          patient.hospitalized=false
          this.$set(this.patients, index, patient);
          this.response = response.data;
          this.snackbar = true;
          });
    },
    updatePatient(id) {
      if (!this.$refs.form.validate()) return false;
      axios
        .patch("http://localhost:3000/patients/" + id, this.patient, this.axios_headers)
        .then((res) => {
          let index = this.patients.findIndex((r) => r.id == res.id);
          this.$set(this.patients, index, res.config.data);
          this.response = res.data;
          this.snackbar = true;
          this.dialog=false;
        })
    },
    async show() {
      await axios
          .get("http://localhost:3000/analysis/" + this.patient.AMKA, this.axios_headers)
          .then((response) => (this.information = response.data));
    },
  },
};
</script>
