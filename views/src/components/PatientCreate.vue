<template>
  <v-container>
    <v-form
      ref="form"
      v-model="valid"
      lazy-validation
      @submit.prevent="submitForm"
    >
      <v-card>
        <v-toolbar flat color="white success--text ">
          <v-icon color="success">mdi-account-plus</v-icon>
          <v-toolbar-title class="font-weight-light">
            Προσθήκη ασθενούς
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
                  label="AMKA*"
                ></v-text-field>
              </v-col>
            </v-row>
            <v-row>
              <v-col cols="12" sm="6">
                <v-text-field
                  v-model="patient.name"
                  :rules="nameRules"
                  label="Όνομα*"
                  color="success"
                  text-color="black"
                ></v-text-field>
              </v-col>
              <v-col cols="12" sm="6">
                <v-text-field
                  v-model="patient.surname"
                  :rules="surNameRules"
                  label="Επώνυμο*"
                  color="success"
                  text-color="black"
                ></v-text-field>
              </v-col>
            </v-row>
            <v-row>
              <v-col cols="12" sm="6">
                <v-text-field
                  v-model="patient.age"
                  label="Ηλικία*"
                  color="success"
                  :rules="[(v) => !!v || 'Πρέπει να είναι θετικός αριθμός', (v) => /^\d+$/.test(v) || 'Πρέπει να είναι θετικός αριθμός']"
                  text-color="black"
                  type="number"
                ></v-text-field>
              </v-col>
              <v-col cols="12" sm="6">
                <v-checkbox
                  v-model="patient.hospitalized"
                  label="Νοσηλεύεται"
                  color="success"
                ></v-checkbox>
              </v-col>
            </v-row>
            <v-row>
              <v-col cols="12">
                <v-select
                  v-model="patient.gender"
                  :items="sex"
                  :rules="[(v) => !!v || 'Απαιτείται το φύλο']"
                  color="success"
                  item-color="success"
                  label="Φύλο*"
                ></v-select>
              </v-col>
            </v-row>
            <v-row>
              <v-col cols="12">
                <v-text-field
                  v-model="patient.description"
                  :rules="[(v) => !!v || 'Απαιτείται περιγραφή']"
                  color="success"
                  label="Περιγραφή*"
                  multiple
                  required
                ></v-text-field>
              </v-col>
            </v-row>
            <div v-if="patient.hospitalized === true">
              <v-row>
                <v-col
                    cols="12"
                    sm="6"

                >
                  <v-slider
                      v-model="information.inflammation"
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

                >
                  <v-slider
                      v-model="information.location"
                      color="success"
                      label="Σημείο μόλυνσης"
                      min="1"
                      max="7"
                      thumb-label
                  ></v-slider>
                </v-col>
              </v-row>

              <v-row>
                <v-col
                    cols="12"
                    sm="12"

                >
                  <v-slider
                      v-model="information.organism"
                      color="success"
                      label="Τύπος μικροοργανισμού"
                      min="1"
                      max="4"
                      thumb-label
                  ></v-slider>
                </v-col>
              </v-row>
              <v-row>
                <v-col
                    cols="12"
                    sm="6"

                >
                  <v-select
                      v-model="information.conditions"
                      :items="conditions"
                      color="green"
                      item-color="green"
                      label="Υποκείμενα νοσήματα"
                      required
                      multiple
                      persistent-hint
                  ></v-select>
                </v-col>
                <v-col
                    cols="12"
                    sm="6"

                >
                  <v-text-field
                      v-model.number="information.PCT"
                      type="number"
                      color="green"
                      label="Αρχική προκαλσιτονίνη*"
                      required
                      @keypress="isNumber($event)"
                      min="0.05"
                      max="252.5"
                      :rules="[(v) => !!v, (v) => (v && v >= 0.05 && v <= 252.5)  || 'Απαιτείται θετικός δεκαδικός εντός των προβλεπόμενων ορίων']"
                  ></v-text-field>
                </v-col>
              </v-row>
              <v-row>
                <v-col
                    cols="12"
                >
                  <v-slider
                      v-model="information.GCS"
                      color="success"
                      label="Κλίμακα κώματος της Γλασκώβης"
                      min="2"
                      max="15"
                      thumb-label
                  ></v-slider>
                </v-col>
              </v-row>
              <v-row>
                <v-col cols="12" sm="12">
                <v-checkbox
                    v-model="information.ventilation"
                    label=Διασωληνωμένος
                    color="success"
                ></v-checkbox>
              </v-col>
              </v-row>
            </div>
          </v-container>
        </v-card-text>
        <v-card-actions class="justify-center">
          <v-btn color="success" type="submit"> Create </v-btn>
        </v-card-actions>
      </v-card>
    </v-form>
    <v-snackbar v-model="snackbar">
      {{ response.data }}

      <template v-slot:action="{ attrs }">
        <v-btn color="success" text v-bind="attrs" @click="snackbar = false">
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
      headers: {headers:{
          'Authorization': `Basic ${localStorage.getItem("accessToken")}`
        }
      },
      patient: {hospitalized: true},
      information: {},
      response: {},
      snackbar: false,
      valid: true,
      conditions: ['Διαβήτης', 'Υπέρταση', 'Χρόνια αποφρακτική πνευμονοπάθεια', 'Στεφανιαία νόσος', 'Συμφορητική καρδιακή ανεπάρκεια', 'Xρόνια νεφρική νόσος με διάλυση',
        'Xρόνια νεφρική νόσος χωρίς διάλυση', 'Kολπική μαρμαρυγή', 'Πνευμονικό εμβολή', 'Καρκίνος'],
      sex: ["Άντρας", "Γυναίκα"],
      AMKARules: [
        (v) => !!v || "Απαιτείται AMKA",
        (v) => /^\d+$/.test(v) || "Το ΑΜΚΑ πρέπει να είναι 11 αριθμοί",
        (v) => (v && v.length == 11) || "Το ΑΜΚΑ πρέπει να είναι 11 αριθμοί",
      ],
      nameRules: [
        (v) => !!v || "Απαιτείται όνομα",
        (v) => /[a-zA-Zα-ωΑ-Ω]+$/.test(v) || "Το όνομα μπορεί να περιέχει μόνο γράμματα",
      ],
      surNameRules: [
        (v) => !!v || "Απαιτείται επώνυμο",
        (v) => /[a-zA-Zα-ωΑ-Ω]+$/.test(v) || "Το επώνυμο μπορεί να περιέχει μόνο γράμματα",
      ],
    };
  },
  methods: {
    submitForm() {
      if (!this.$refs.form.validate()) return false;
        axios
          .post("http://localhost:3000/patients", this.patient, this.headers)
          .then(() => {
            if (this.information){
              this.information.AMKA = this.patient.AMKA
              axios.post("http://localhost:3000/analysis", this.information, this.headers)
              .then(() => {
                this.$router.push({
                  name: "View patients",
                  params: { message: "Προστέθηκε ασθενής " },
                })
                this.snackbar = true
              })
              .catch((err)=>{
                this.$router.push({
                  name: "View patients",
                  params: { message: err },
                })
                this.snackbar = true
              });
            }
          })
          .catch((err)=>{
              this.$router.push({
                name: "View patients",
                params: { message: err },
              })
              this.snackbar = true
            });

    },
    isNumber(evt) {
      evt = (evt) ? evt : window.event;
      var charCode = (evt.which) ? evt.which : evt.keyCode;
      if ((charCode > 31 && (charCode < 48 || charCode > 57)) && charCode !== 46) {
        evt.preventDefault();
      } else {
        return true;
      }
    },
  },
};
</script>
