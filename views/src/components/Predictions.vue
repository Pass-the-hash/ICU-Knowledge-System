<template>
  <div>
    <h1 align="center" class="title  pt-10"> Ενδείξεις υποσυστήματος τεχνητής νοημοσύνης:</h1>
    <v-row class="pb-15">
      <v-col cols="12" >
        <apexchart width="500" :options="mortality" :series="series1"></apexchart>
      </v-col>
      <v-col cols="12" >
          <apexchart width="500" :options="vasopressors" :series="series2"></apexchart>
      </v-col>
    </v-row>
  </div>
</template>

<script>
import axios from "axios";

export default {
  name: "Predictions",
  props: {
    patient: {
      type: Object,
      required: true
    },
    headers: {},
  },
  data: () =>({
    mortality: {
      chart: {
        id: 'vuechart-example',
        foreColor: 'black',
        type: 'radialBar',
      },
    },
    vasopressors: {
      chart: {
        id: 'vuechart-example2',
        foreColor: 'black',
        type: 'radialBar',
      },
    },
    series1: [],
    series2: [],
    response: [],
  }),
  methods: {
    getPredictions() {
      axios
        .get("http://localhost:3000/analysis/" + this.patient.AMKA + "/prediction", this.headers)
        .then((response) => {
          this.response = response.data
        })
        .then(() => {
          this.updateChart()
          console.log(this.response)
        })
    },
    updateChart() {
      this.series1 = [this.response[0]]
      this.series2 = [this.response[1]]

      let color;
      if (this.series1[0] < 30.0) color = '#de1037'
      else if (this.series1[0] < 60.0) color = '#f1b626'
      else color = '#38b726'

      this.mortality = {

        colors: [color],
        series: this.series1,
        plotOptions: {
          radialBar: {
            hollow: {
              size: 80,
            }
          },
        },
        labels: ['Ποσοστό επιβίωσης'],
      }
      this.vasopressors = {
        series: this.series2,
        // series: [{data: this.response[1]}],
        plotOptions: {
          radialBar: {
            hollow: {
              size: 80,
            }
          },
        },
        labels: ['Πρόταση χρήσης αγγειοσυσταλτικών'],
      }
    }
  },
  mounted() {
    this.getPredictions()
  },
}
</script>
